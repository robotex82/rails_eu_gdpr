module Model
  module EuGdpr
    module PersonalDataConcern
      extend ActiveSupport::Concern

      class_methods do
        def personal_data_attributes=(attribute_names)
          @personal_data_attributes = attribute_names
        end

        def personal_data_attributes
          @personal_data_attributes
        end

        def gdpr_export_options=(options)
          @gdpr_export_options = options
        end

        def gdpr_export_options
          @gdpr_export_options ||= {}
        end
      end
    end
  end
end
