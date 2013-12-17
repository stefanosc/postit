class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have successfully registered"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new  
    end

  end

  def show
    
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end