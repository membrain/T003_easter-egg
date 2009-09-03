# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jest_session',
  :secret      => '3ec8ec8d80314bc52efba272caec17b11acf54ca2ef28ccdc4e8a90d58a8d8e1ab93ced9c2e1a945a371bd64ded8a76d96d8ea88a93845a0adbd960c2bb89c09'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
