Given /^a pub is called "([^\"]*)"$/ do |pub_name|
  Pub.make(:name => pub_name)
end
