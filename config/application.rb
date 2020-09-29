require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mutualaid
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators do |g|
      g.assets            false
      g.helper            false
      g.test_framework    :rspec
      g.jbuilder          false
      g.scaffold_stylesheet false
    end

    # Permitted locales available for the application
    I18n.available_locales = [:ar, :cs, :en, :es, :de, :fr, :pt, :th]
    config.i18n.enforce_available_locales
    # Mobility gem will fallbacks to locale set here
    I18n.default_locale = :en
    config.i18n.fallbacks = true

    config.time_zone = 'UTC'

    # ActionMailer config
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_caching = false
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = ENV['RAISE_MAIL_DELIVERY_ERRORS'] != 'false'
    config.action_mailer.smtp_settings = {
      address:   ENV['SMTP_HOST'],
      port:      (ENV['SMTP_PORT'].presence || 587).to_i,
      user_name: ENV['SMTP_USERNAME'],
      password:  ENV['SMTP_PASSWORD'],
      domain:    ENV['SYSTEM_HOST_NAME'],
      authentication: 'plain',
      enable_starttls_auto: true,
    }
    config.action_mailer.default_url_options = {
      host: ENV['SYSTEM_HOST_NAME'],
      port: (ENV['PORT'].presence || 80).to_i,
    }
  end
end
