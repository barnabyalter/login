require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

require 'nyulibraries-assets'

require 'figs'
# Don't run this initializer on travis.
Figs.load(stage: Rails.env) unless ENV['TRAVIS']

module Login
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = true

    # Mailer default URL options
    config.action_mailer.default_url_options = { protocol: "https", host: "login.library.nyu.edu" }

    # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
    config.force_ssl = true

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # It seems like images are included by default only from app/assets folder
    # So in order to get images from shared assets we do this
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end
