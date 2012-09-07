# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout "two_column"

  filter_parameter_logging :password

  def find_pub
    @pub = Pub.find(params[:pub_id])
  end
end
