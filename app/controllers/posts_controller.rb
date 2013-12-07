class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    # @user = User.find(@post.user_id)
  end

  def index
    @posts = Post.all
  end
  
end
