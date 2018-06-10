Rails.application.config.to_prepare do
  EuGdpr.configure do |config|
    # Set the base controller
    #
    # Default: config.base_controller = 'FrontendController'
    #
    config.base_controller = '::Frontend::ApplicationController'

    # Add these attributes to the rails logging filter
    #
    # default: config.filter_personal_data_attributes = [:email, :firstname, :lastname, :birthdate]
    #
    config.filter_personal_data_attributes = [:email, :firstname, :lastname, :birthdate]

    # If set to true and force_ssl is not set to true in production it will raise
    # an exception when trying to boot rails.
    #
    # default: config.enforce_ssl = true
    #
    config.enforce_ssl = true

    # Enables or disables the cookie message.
    #
    # default: config.enable_cookie_consent_banner = true
    #
    config.enable_cookie_consent_banner = true

    # config.personal_data.register('User', log_removals: true, forget_with: :anonymization) do |u|
    #   u.attribute(:email, anonymize_with: :scrambler)
    #   u.attribute(:firstname, anonymize_with: :scrambler)
    #   u.attribute(:lastname, anonymize_with: :scrambler)
    #   u.attribute(:last_ip, anonymize_with: :nullifier)
    #   u.association(:posts) do |p|
    #     p.attribute(:title)
    #     p.attribute(:body)
    #     p.association(:gallery) do |g|
    #       g.attribute(:name)
    #       g.association(:pictures) do |p|
    #         p.attribute(:title)
    #         p.attribute(:asset) { |r| r.base64_encoded_asset }
    #       end
    #     end
    #   end
    # end
  end
end