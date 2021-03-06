require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppDev
  class Application < Rails::Application
    # Use Google Analytics
    config.middleware.use Rack::GoogleAnalytics, tracker: Rails.application.secrets.google_analytics_tracking_id
    
    # Disable automatic generation for TestUnit, JS, CSS files and helpers
    config.generators do |g|
      g.test_framework :rspec, views: false, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end