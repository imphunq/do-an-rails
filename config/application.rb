require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thuctap
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.paths << Rails.root.join('vendor', 'stylesheets')
    config.assets.paths << Rails.root.join('vendor', 'javascripts')
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    Rails.application.routes.default_url_options[:locale]= I18n.locale
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "gmail.com",
      user_name: "phube232@gmail.com",
      password: "quangphu2321998",
      authentication: "plain"
      # enable_starttls_auto: true
    }
    config.action_mailer.asset_host = 'http://localhost:3000'
    config.action_controller.asset_host = "http://localhost:3000"
    config.active_job.queue_adapter = :sidekiq
  end
end
