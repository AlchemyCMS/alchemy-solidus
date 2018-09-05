require_relative 'boot'

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "alchemy-solidus"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1 if config.respond_to? :load_defaults

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    if config.active_record.sqlite3.respond_to?(:represent_boolean_as_integer=)
      config.active_record.sqlite3.represent_boolean_as_integer = true
    end
  end
end
