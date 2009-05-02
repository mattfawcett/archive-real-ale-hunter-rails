User.blueprint do
  username "matt"
  email "mail@matthewfawcett.co.uk"
  level 3
  pints 100
end

Pub.blueprint do
  name  "Grove"
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
