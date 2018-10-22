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

    def render_cookie_preferences(options = {})
      options.reverse_merge!(collapsible_preferences: true, show_hint: true)
      collapsible_preferences = options.delete(:collapsible_preferences)
      show_hint = options.delete(:show_hint)

      resource = ::EuGdpr::CookiePreferences.new(cookie_store: ::EuGdpr::CookieStore.new(cookie_storage))

      c.capture do
        c.concat c.render :partial => 'eu_gdpr/cookie_preferences/hint', locals: { collapsible_preferences: collapsible_preferences } if show_hint
        c.concat c.render :partial => 'eu_gdpr/cookie_preferences/form', locals: { resource: resource, collapsible_preferences: collapsible_preferences }
      end.html_safe
    end

    private

    def cookie_storage
      c.send(::EuGdpr::Configuration.cookie_storage)
    end
  end
end