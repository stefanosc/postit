class CommentsController < ApplicationController
  
  def create
    require_user
    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    @comment.user = User.first

    if @comment.save
      flash[:notice] = "Successfully created comment"
      redirect_to post_path(@post)
    else
        render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
    
  end
  
end