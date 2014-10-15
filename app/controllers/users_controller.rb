class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create, :show]

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
    @user = User.find(session[:user_id])
  end

  def edit
  end

  def update
    current_user.update(user_params)

    if current_user.save
      flash[:notice] = "You have successfully updated your profile"
      redirect_to user_path
    else
      render :edit
    end
  end

  private


  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

end