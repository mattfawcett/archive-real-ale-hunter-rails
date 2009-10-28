When /^I have already rated the "([^\"]*)"$/ do |pub_name|
  pub = Pub.find_by_name(pub_name)
  pub.ratings.make(:user => User.find_by_username("matt"))
end
