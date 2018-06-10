Rails.application.config.after_initialize do
  Rails.application.config.filter_parameters += EuGdpr::Configuration.filter_personal_data_attributes
end if EuGdpr::Configuration.filter_personal_data_attributes.is_a?(Array)