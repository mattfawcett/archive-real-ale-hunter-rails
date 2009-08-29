require "#{RAILS_ROOT}/config/phpbb_auth_settings"

module PhpbbAuth  
  def current_user
    unless cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"].nil?
      @phpbb_session = PhpbbSession.find_by_session_id(cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"])
      unless @phpbb_session.nil? || !@phpbb_session.logged_in?
        local_user = User.find_by_email(@phpbb_session.phpbb_user.user_email)       
        if !local_user
          # We don't have the user registered in the local database, lets create them
          local_user = User.create!(:email => @phpbb_session.phpbb_user.user_email)
        end
        return local_user
      end
    end
  end
end
