Rails.application.config.after_initialize do
  if Rails.env.production? && EuGdpr::Configuration.enforce_ssl?
    raise "[EU GDPR] Legal regulations require enabled ssl (via force_ssl), but force_ssl is not set to true for production environment." unless Rails.application.config.force_ssl == true
  end
end