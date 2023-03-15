require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Custom
require "trust_gem"
require "trust_gem/trace_capture"
require "trust_gem/scope_check"
require "trust_gem/log_events"
require "trust_gem/authorization_check"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApi
  class Application < Rails::Application

    # Load dotenv only in development or test environment
    if ['development', 'test'].include? ENV['RAILS_ENV']
      Dotenv::Railtie.load
    end

    HOSTNAME = ENV['HOSTNAME']

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    ENV['PROJECT_VERSION'] = '1.0.0'
    ENV['PROJECT_NAME'] = 'Trust Example'
    ENV['FORCE_AUTHENTICATION'] = "true"

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
