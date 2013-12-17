class PostsController < ApplicationController
  
  before_action :set_post, only:[:show, :edit, :update]

  def show
    @comment = Comment.new
  end

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    
    @post.creator = User.first

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
    @post.update(post_params)

    if @post.save
      flash[:notice] = "Your post was successfully updated"
      redirect_to posts_path
    else
      render :edit
    end

  end

  def search
    @q = params.permit(:q)[:q]
    @posts = Post.where('description LIKE ? or title LIKE ? or url LIKE ?', "%#{@q}%","%#{@q}%","%#{@q}%")
    

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :url, category_ids: [])
    
  end

end


# Create all the typical actions for the Post resource (index, show, new, create, edit, update). Use model backed forms to create and edit post objects. Also extract the post form to a partial, to be used by both the new and edit templates. Add a validation and make sure the validation fires and you display the error on the template.