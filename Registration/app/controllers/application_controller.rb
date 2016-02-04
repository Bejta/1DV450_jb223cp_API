class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # || does not change variable if it is already sett
  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end
  
  private
  def require_login
    if current_user.nil? then
      flash[:danger] = ''
      redirect_to root_path
    end
  end
end
