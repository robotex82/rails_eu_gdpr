module Controller
  module EuGdpr
    module CookieConcern
      extend ActiveSupport::Concern
      included do
        helper_method :eu_gdpr_helper
      end

      private

      def eu_gdpr_helper(context)
        ::EuGdpr::Helper.new(context)
      end
    end
  end
end