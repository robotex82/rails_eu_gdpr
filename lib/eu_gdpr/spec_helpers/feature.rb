module EuGdpr
  module SpecHelpers
    module Feature
      def accept_eu_gdrp_cookies
        find('#eu-gdpr-cookies-accept').click
      end
    end
  end
end