Given /^a pub is called "([^\"]*)"$/ do |pub_name|
  Pub.make(:name => pub_name)
end

Given /^I have no pubs$/ do
  Pub.delete_all
end

