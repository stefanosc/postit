class SessionsController < ApplicationController

  def new
    session[:login_referrer] = request.env["HTTP_X_XHR_REFERER"] if !session[:login_referrer]
  end

  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      referrer = session[:login_referrer]
      session[:login_referrer] = nil
      session[:user_id] = user.id
      flash[:notice] = "You have logged in"
      redirect_to referrer
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