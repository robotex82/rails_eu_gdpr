
module EuGdpr
  class Cookie
    include ActiveModel::Model
    
    attr_accessor :identifier, :adjustable, :default, :value, :cookie_store

    def initialize(attributes = {})
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    def self.to_boolean(string)
      return true  if ['true', true, "1", 1].include?(string)
      return false if ['false', false, "0", 0, nil].include?(string)
      raise "Can't translate #{string} to boolean"
    end

    def self.all(cookie_store = nil)
      EuGdpr::Configuration.cookies.call(cookie_store)
    end

    def self.first(cookie_store = nil)
      all(cookie_store).first
    end

    def self.accepted(cookie_store = nil)
      all(cookie_store).select { |resource| resource.accepted? }
    end

    def value
      initialize_value if @value.nil?
      self.class.to_boolean(@value)
    end
    
    def value=(value)
      @value = self.class.to_boolean(value)
    end

    def value_from_cookie_store
      cookie_store.get_value(identifier)
    end

    def accepted?
      !!value
    end

    def readonly?
      !adjustable
    end

    def save
      cookie_store.set_value(identifier, value)
    end

    def pending?
      value_from_cookie_store.nil?
    end
    
    private

    def initialize_value
      @value = pending? ? default : value_from_cookie_store
    end

    def cookie_store
      @cookie_store ||= ::EuGdpr::CookieStore.new({})
    end
  end
end