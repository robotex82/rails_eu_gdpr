module EuGdpr
  class ApplicationViewHelper < Rao::ViewHelper::Base
    def render_cookie_consent_banner
      return unless ::EuGdpr::Configuration.enable_cookie_consent_banner

      unless c.url_for() == c.eu_gdpr.privacy_policy_path(options_for_url_helper) || c.url_for() == c.eu_gdpr.edit_cookie_preferences_path(options_for_url_helper)
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

    def options_for_url_helper
      if Gem.loaded_specs["route_translator"].present?
        { locale: I18n.locale }
      elsif Gem.loaded_specs["i18n_routing"].present?
        { i18n_locale: I18n.locale }
      else
        {}
      end
    end

    private

    def cookie_storage
      c.send(::EuGdpr::Configuration.cookie_storage)
    end
  end
end