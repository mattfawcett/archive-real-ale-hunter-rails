When /I request page "([^\"]*)"$/ do |path|  
  adapter = MechanizeWorld.new
  @full_stack_session = Webrat::Session.new(adapter)
  @full_stack_session.visit("http://app.dev.realalehunter.co.uk#{path}")
end

Then /^I should be redirected to path "([^\"]*)"$/ do |path|
  @full_stack_session.response.uri.to_s.should eql("http://app.dev.realalehunter.co.uk#{path}")
end
