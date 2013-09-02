Devise.setup do |config|
  require 'devise/orm/active_record'
  config.mailer_sender = "mailer@scarfapp.com"
  # config.mailer = "Devise::Mailer"
  # config.authentication_keys = [ :email ]
  # config.request_keys = []
  config.case_insensitive_keys = %i(email)
  config.strip_whitespace_keys = %i(email)
  # config.params_authenticatable = true
  # config.http_authenticatable_on_xhr = true
  # config.http_authentication_realm = "Application"
  # config.paranoid = true
  config.skip_session_storage = [:http_auth]
  # config.clean_up_csrf_token_on_authentication = true
  config.stretches = Rails.env.test? ? 1 : 10
  # config.pepper = "b413929b00d37fc70a3153b5530290003a1bd1696bb9fc417fec1009dcf9ee726d0b3016c2c3f19f7d99aff1b71e8a4c924301e3ebd140c70f0cf354d6696e7d"
  # config.allow_unconfirmed_access_for = 2.days
  # config.confirm_within = 3.days
  config.reconfirmable = true
  # config.confirmation_keys = [ :email ]
  # config.remember_for = 2.weeks
  # config.extend_remember_period = false
  # config.rememberable_options = {}
  config.password_length = 8..128
  # config.email_regexp = /\A[^@]+@[^@]+\z/
  # config.timeout_in = 30.minutes
  # config.expire_auth_token_on_timeout = false
  # config.lock_strategy = :failed_attempts
  # config.unlock_keys = [ :email ]
  # config.unlock_strategy = :both
  # config.maximum_attempts = 20
  # config.unlock_in = 1.hour
  # config.reset_password_keys = [ :email ]
  config.reset_password_within = 6.hours
  # config.token_authentication_key = :auth_token
  # config.scoped_views = false
  # config.default_scope = :user
  # config.sign_out_all_scopes = true
  # config.navigational_formats = ["*/*", :html]
  config.sign_out_via = :delete
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', :scope => 'user,public_repo'
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(:scope => :user).unshift :some_external_strategy
  # end
  # config.router_name = :my_engine
  # config.omniauth_path_prefix = "/my_engine/users/auth"
end
