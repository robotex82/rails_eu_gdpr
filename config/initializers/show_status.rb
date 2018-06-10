Rails.application.config.after_initialize do
  if EuGdpr::Configuration.enforce_ssl?
    puts "[EU GDPR] Traffic encryption check (via force_ssl) => [OK]"
  else
    puts "[EU GDPR] Warning: Traffic encryption check (via force_ssl) => [FALSE]"
  end

  if EuGdpr::Configuration.enable_cookie_consent_banner?
    puts "[EU GDPR] Cookie consent banner enabled? => [OK]"
  else
    puts "[EU GDPR] Warning: Cookie consent banner enabled? => [FALSE]"
  end

  puts "[EU GDPR] Filtered personal data attributes => #{EuGdpr::Configuration.filter_personal_data_attributes.join(", ")}"
end