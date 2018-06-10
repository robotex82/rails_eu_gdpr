Rails.application.config.to_prepare do
  EuGdpr::Configuration.personal_data_root_classes.call.each do |model, options|
    model.send(:include, Model::EuGdpr::PersonalDataConcern)
    model.personal_data_attributes = options[:personal_data_attributes]
    model.gdpr_export_options = { :only => options[:personal_data_attributes] }
  end
end if EuGdpr::Configuration.personal_data_root_classes.respond_to?(:call)