require "webrat/mechanize"



Given /^I am logged in$/ do
  @matt = User.make(:username => "matt", :email => "mail@matthewfawcett.co.uk")
  @current_user = @matt
  # session = Webrat::MechanizeSession.new
  # session.visit("http://localhost/rah/application/forum/ucp.php?mode=login")
  # session.fill_in("username", :with => "matt") 
  # session.fill_in("password", :with => "cdzvc4a") 
  # session.click_button("Login")
  # session.response.body.should contain("You have been successfully logged in")
  # ApplicationController.should_receive(:current_user)
  # puts "THE INSTANCE METHODS ARE #{session.methods.inspect}"
  ApplicationController.stub!(:current_user).and_return(@current_user)
end

Then /^I should say what I see$/ do 
  puts response.body
end
