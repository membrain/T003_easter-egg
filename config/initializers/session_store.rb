# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_T003_easter-egg_session',
  :secret      => '61c274883fec73eff3caeb7ea1fd409196c5a3ce2be0d834dafd1ff77291105d483218c066771d4be6d327e41130a9dd3308d32b7d509b4f8165b6470078cc11'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
