class SessionsController < ApplicationController

  def new
    redirect_to profile_path if logged_in?
    session[:login_referrer] = request.env["HTTP_REFERER"] if !session[:login_referrer]
  end

  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have logged in"
      redirect_to session[:login_referrer]
      session[:login_referrer] = nil
    else
      flash[:error] = "Oops there was a problem with your username or password"
      render :new 
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end

end