module Model
  module EuGdpr
    module PersonalDataConcern
      extend ActiveSupport::Concern

      # Backport class_methods method.
      if Rails.version < '4.2'
        def self.class_methods(&class_methods_module_definition)
          mod = const_defined?(:ClassMethods, false) ?
            const_get(:ClassMethods) :
            const_set(:ClassMethods, Module.new)

          mod.module_eval(&class_methods_module_definition)
        end
      end

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
