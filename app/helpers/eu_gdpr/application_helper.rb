module EuGdpr
  module ApplicationHelper
    def render_cookie_consent_banner(options = {})
      return unless EuGdpr::Configuration.enable_cookie_consent_banner

      options.reverse_merge!(:link => eu_gdpr.privacy_policy_path)

      unless url_for() == eu_gdpr.privacy_policy_path
        render('eu_gdpr/cookies/consent_banner', options) 
      end
    end
  end
end
