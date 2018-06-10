module EuGdpr
  class PrivacyPoliciesController < EuGdpr::Configuration.base_controller.constantize
    # include ResourcesController::Resources
    # include ResourcesController::ResourceInflections
    # include ResourcesController::RestResourceUrls
    # include ResourcesController::RestActions
    # include ResourcesController::LocationHistory
    
    prepend_view_path ::EuGdpr::PrivacyPolicyResolver.instance unless view_paths.include?(::EuGdpr::PrivacyPolicyResolver.instance)

    def show
    end
  end
end