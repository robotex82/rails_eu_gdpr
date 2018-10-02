module EuGdpr
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { Proc.new {{}} }
    mattr_accessor(:personal_data_root_classes) { Proc.new {{}} }
    mattr_accessor(:filter_personal_data_attributes) { [] }
    mattr_accessor(:enforce_ssl) { true }
    mattr_accessor(:enable_cookie_consent_banner) { true }
    mattr_accessor(:cookies) { ->(cookie_store = ::EuGdpr::CookieStore.new({})) { [] } }
    mattr_accessor(:cookie_prefix) { "eu_gdpr-" }
    mattr_accessor(:cookie_storage) { :cookie }

    def personal_data
      @personal_data ||= ::EuGdpr::PersonalDataRegistry.instance
    end

    def self.enforce_ssl?
      enforce_ssl
    end

    def self.enable_cookie_consent_banner?
      enable_cookie_consent_banner
    end

    def self.privacy_policy_defaults_for(locale)
      privacy_policy_defaults[locale.to_sym]
    end

    def self.privacy_policy_available_for(locale)
      EuGdpr::PrivacyPolicy.where(:locale => locale).any?
    end

    def self.filtered_log_parameters
      Rails.application.config.filter_parameters
    end
  end
end
