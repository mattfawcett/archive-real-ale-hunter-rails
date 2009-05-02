# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_real-ale-hunter-rails_session',
  :secret      => 'b13ba2397ca83a3682d2466cd5ded7dcc73f989ad74d1597692042437f1aec6ee27cfa74b7b5f249b010be81aab2a30ec0d4cd7c2952e8ccfc1b68079284ccde'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
