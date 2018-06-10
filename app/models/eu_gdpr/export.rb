module EuGdpr
  class Export
    include ActiveModel::Model

    attr_accessor :personal_data_attributes, :klass, :instance_getter, :gdpr_export_options

    def self.all
      EuGdpr::Configuration.personal_data_root_classes.call.map { |klass, options| new(options.merge(klass: klass)) }
    end

    def self.find(id)
      all.select { |export| export.klass.name.underscore.gsub('/', '-') == id }.first
    end

    def id
      klass.name.underscore.gsub('/', '-')
    end

    def to_key
      klass.name.underscore.split('/')
    end

    def instance(controller)
      instance_getter.call(controller)
    end

    def data(controller)
      instance(controller).as_json({ only: personal_data_attributes }.merge(gdpr_export_options))
    end
  end
end
