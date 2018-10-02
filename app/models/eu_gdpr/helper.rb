module EuGdpr
  class Helper
    def initialize(context)
      @context = context
    end

    def c
      @context
    end

    def render_cookie_consent_banner
      return unless ::EuGdpr::Configuration.enable_cookie_consent_banner

      unless c.url_for() == c.eu_gdpr.privacy_policy_path
        c.render('eu_gdpr/cookies/consent_banner') 
      end
    end

    def cookie_preferences_pending?
      cookie_preferences.cookies.any?(&:pending?)
    end

    def cookie_preferences
      ::EuGdpr::CookiePreferences.new(cookie_store: ::EuGdpr::CookieStore.new(cookie_storage))
    end

    def render_cookie_preferences
      resource = ::EuGdpr::CookiePreferences.new(cookie_store: ::EuGdpr::CookieStore.new(cookie_storage))
      c.render :partial => 'eu_gdpr/cookie_preferences/hint'
      c.render :partial => 'eu_gdpr/cookie_preferences/form', locals: { resource: resource }
    end

    private

    def cookie_storage
      c.send(::EuGdpr::Configuration.cookie_storage)
    end
  end
end