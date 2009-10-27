require "webrat/mechanize"



Given /^I am logged in$/ do
  @matt = User.make(:username => "matt", :email => "mail@matthewfawcett.co.uk")
  @current_user = @matt
  adapter = MechanizeWorld.new
  session = Webrat::Session.new(adapter)
  session.visit("http://localhost/real-ale-hunter/application/forum/ucp.php")  
  session.fill_in("username", :with => "matt") 
  session.fill_in("password", :with => "cdzvc4a") 
  session.click_button("Login")
  session.response.body.should contain("You have been successfully logged in")
  #puts "COOKIES ARE #{session.cookies.inspect}"
  puts "RESPONSE HEADERS ARE #{session.response.header.inspect}"
  puts "REQUEST HEADERS ARE #{session.request.inspect}"
  puts "COOKIES ARE #{adapter.mechanize.cookies.inspect}"
  session.methods.each {|m| puts "NEXT METHOD #{m}<br>"}
end

Then /^I should say what I see$/ do 
  puts response.body
end
