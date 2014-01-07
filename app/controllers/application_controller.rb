class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_user, :require_guest, :require_admin

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You need to be logged in to access this feature"
      session[:login_referrer] = request.env["HTTP_X_XHR_REFERER"]
      redirect_to(login_path)
    end
  
  end 

  def require_guest
    if logged_in?
      flash[:notice] = "You cannot access this page when you are logged in. Please logout first"
      redirect_to profile_path
    end
  end

  def require_admin
    not_authorized unless logged_in? and current_user.admin?
  end

  def not_authorized
    flash[:error] = "You are not authorized to perform this action"
    redirect_to :back
  end

end
