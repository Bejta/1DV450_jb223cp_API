class ApplicationController < ActionController::Base
  
  #Knock gem for authentication
  #include Knock::Authenticable
 
  before_filter :cors_set_access_control_headers
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  
  private
  helper_method :current_user
  
  # || does not change variable if it is already set
  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end
  
  #Check if user has admin permissions
  private
  def is_admin
    if !current_user.admin
      flash[:warning] = 'You do not have administrator permissions'
      redirect_to client_path
    end
  end
  
  private
  def require_login
    if current_user.nil? then
      flash[:warning] = 'You have to login first'
      redirect_to root_path
    end
  end
end
