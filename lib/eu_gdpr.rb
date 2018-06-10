require "awesome_print"
require "cookies_eu"
require "eu_gdpr/configuration"
require "eu_gdpr/engine"
require "active_model/model" if Rails::VERSION::MAJOR < 4
require "eu_gdpr/personal_data_registry"

module EuGdpr
  extend Configuration
end
