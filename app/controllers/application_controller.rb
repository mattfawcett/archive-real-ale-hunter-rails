# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #include PhpbbAuth
  before_filter :set_current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def set_current_user
    @current_user ||= current_user
  end
  
  def require_login
    unless @current_user
      flash[:notice] = "you need to be logged in to do this"
      redirect_to :back
    end
  end
end
