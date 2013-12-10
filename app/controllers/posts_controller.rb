class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was successfully created"
      redirect_to posts_path
    else
      
      render :new
    end
    
  end

  def edit
    @post = Post.find(params[:id])
    
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    if @post.save
      flash[:notice] = "Your post was successfully updated"
      redirect_to posts_path
    else
      render :edit
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url)
    
  end

end


# Create all the typical actions for the Post resource (index, show, new, create, edit, update). Use model backed forms to create and edit post objects. Also extract the post form to a partial, to be used by both the new and edit templates. Add a validation and make sure the validation fires and you display the error on the template.