When /^I have already rated the "([^\"]*)"$/ do |pub_name|
  pub = Pub.find_by_name(pub_name)
  pub.ratings.make
end
