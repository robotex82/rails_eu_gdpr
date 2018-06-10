module EuGdpr
  class PrivacyPoliciesController < EuGdpr::Configuration.base_controller.constantize
    if Gem.loaded_specs["ecm_cms2"].present?
      prepend_view_path ::EuGdpr::PrivacyPolicyResolver.instance unless view_paths.include?(::EuGdpr::PrivacyPolicyResolver.instance)
    end

    def show
    end
  end
end