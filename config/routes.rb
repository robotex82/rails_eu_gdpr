EuGdpr::Engine.routes.draw do
  if Gem.loaded_specs["route_translator"].present?
    localized do
      resource :privacy_policy, :only => [:show]
      scope :eu_gdpr_engine do
        resource :cookie_preferences, :only => [:edit, :update]
      end
    end
  elsif Gem.loaded_specs["i18n_routing"].present?
    localized(I18n.available_locales) do
      scope "/:i18n_locale", :constraints => {:i18n_locale => /#{I18n.available_locales.join('|')}/} do
        resource :privacy_policy, :only => [:show]
        scope :eu_gdpr_engine do
          resource :cookie_preferences, :only => [:edit, :update]
        end
      end
    end
  else
    resource :privacy_policy, :only => [:show]
    scope :eu_gdpr_engine do
      resource :cookie_preferences, :only => [:edit, :update]
    end
  end
end
