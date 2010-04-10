require 'machinist/active_record'
require 'sham'


User.blueprint do
  username "matt"
  email "mail@matthewfawcett.co.uk"
  level 3
  pints 100
  twitter_username "mattfawcett"
end

Pub.blueprint do
  name "Grove"
  description "The Grove is a real gem"
  address_1 "Back row"
  address_2 "Holbeck"
  town "Leeds"
  post_code "LS11 5PL"
  telephone "01132 439254"
  user
  gbg true
  cask_marque false
end


Visit.blueprint do
  comments "very nice indeed"
  user
  pub
end

Rating.blueprint do   
  beer_quality 2
  beer_selection 5
  atmosphere 3
  price 1
  overall_option 3
  user
  pub
end

Beer.blueprint do
  name "Summer Lightning"
end
