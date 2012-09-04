# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'shoulda'
require 'rspec/rails'
require 'machinist'
require File.expand_path(File.dirname(__FILE__) + "/image_spec_helper")

require File.expand_path(File.dirname(__FILE__) + "/blueprints")


RSpec.configure do |config|
  config.mock_with :rspec
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = Rails.root + '/spec/fixtures/'

  config.before(:each) { Sham.reset }

end

def login_as(user)
  #cookies["phpbb3_7uah4_sid"] = 'abcd'
  #mock_user = mock_model(PhpbbUser, {:user_email => 'phpbbsessionemail', :username => 'dave'})
  #mock_session = mock_model(PhpbbSession, :logged_in? => true, :phpbb_user => mock_user)
  #PhpbbSession.stub!(:find_by_session_id).and_return(mock_session)
  #User.stub!(:find).with(:first, :conditions => {'username' => 'dave'}).and_return(user)

  sign_in :user, user
end
