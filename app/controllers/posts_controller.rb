class PostsController < ApplicationController

  
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :search]
  before_action :require_creator, only: [:edit, :update]

  def show  
    @comment = Comment.new


    respond_to do |format|
      format.html
      format.json do
        if params[:author]
          render json: @post.as_json(include_creator: true)
        else
          render json: @post
        end
     end
    end
  end

  def index
    @posts = Post.limit(10)
  end
  
  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was successfully created"
      redirect_to posts_path
    else

      render :new
    end
    
  end

  def edit    
  end

  def update
    
    @old_slug = @post.slug if !@post.nil? # track the slug before updating to identify div to replace in update.js.erb
    
    

    respond_to do |format|
      
      format.html do
        @post.update(post_params)
        if @post.save
          flash[:notice] = "Your post was successfully updated"
          redirect_to posts_path
        else
          render :edit
        end
      end

      format.js do
        if params[:commit] == "Cancel"
          render :cancel_edit
          
        elsif params[:commit] == "Update Post"
          @post.update(post_params)
          if @post.save
            render :update
          else
            render :edit
          end

        end
      end

    end

    

  end

  def vote
    @vote = Vote.create(votable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          redirect_to :back, notice: 'Your vote was registered'
        else
          flash[:error] = "You have already voted on this post"
        end
      end
      format.js 
    end


    # if @vote.valid?
    #   flash[:notice] = "Your vote was registered"
    # else
    #   flash[:error] = "You have already voted on this post"
    # end

    # redirect_to :back
    
  end

  def search
    @q = params.permit(:q)[:q]
    @posts = Post.where('description LIKE ? or title LIKE ? or url LIKE ?', "%#{@q}%","%#{@q}%","%#{@q}%")
    

  end


  private

  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :url, :vote, category_ids: [])
    
  end

  def require_creator
    not_authorized unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end

end
