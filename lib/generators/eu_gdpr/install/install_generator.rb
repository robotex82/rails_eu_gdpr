module EuGdpr
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs the initializer and routes'

      source_root File.expand_path('../templates', __FILE__)

      def generate_initializer
        copy_file 'initializer.rb', 'config/initializers/eu_gdpr.rb'
      end

      def generate_routes
        route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
      end
    end
  end
end