# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'shoulda'
require 'spec'
require 'spec/rails'
require 'machinist'
require 'spec/image_spec_helper'

require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require File.expand_path(File.dirname(__FILE__) + '/matchers')


Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  config.include(Matchers)
  config.before(:each) { Sham.reset }

end

def login_as(user)
  cookies["phpbb3_7uah4_sid"] = 'abcd'
  mock_user = mock_model(PhpbbUser, {:user_email => 'phpbbsessionemail', :username_clean => 'dave'})
  mock_session = mock_model(PhpbbSession, :logged_in? => true, :phpbb_user => mock_user)
  PhpbbSession.stub!(:find_by_session_id).and_return(mock_session)
  User.stub!(:find).with(:first, :conditions => {'email' => 'phpbbsessionemail'}).and_return(user)
end
