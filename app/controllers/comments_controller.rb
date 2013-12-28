class CommentsController < ApplicationController
  before_action :require_user

  def create

    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Successfully created comment"
      redirect_to post_path(@post)
    else
        render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, creator: current_user, vote: params[:vote])

    
    respond_to do |format|
      format.html { redirect_to :back, notice: "Your vote was registered"}
      format.js
    end

    # if @vote.valid?
    #   flash[:notice] = "Your vote was registered"
    # else
    #   flash[:error] = "You have already voted on this comment"
    # end

    # redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
    
  end
  
end