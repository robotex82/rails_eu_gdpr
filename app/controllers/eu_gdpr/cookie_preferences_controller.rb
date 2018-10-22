module EuGdpr
  class CookiePreferencesController < EuGdpr::Configuration.base_controller.constantize
    if respond_to?(:before_action)
      before_action :initialize_resource, :only => [:edit, :update]
    else
      before_filter :initialize_resource, :only => [:edit, :update]
    end

    def edit
    end

    def update
      respond_to do |format|
        if @resource.update_attributes(permitted_params)
          format.html { redirect_to((request.referer || url_for(action: 'edit')), notice: t(flash_message_success_key)) }
        else
          format.html { render :edit }
        end
      end
    end

    private

    def flash_message_success_key
      if Rails.version < '4.0'
        'eu_gdpr.cookie_preferences.update.success'
      else
        '.success'
      end
    end

    def permitted_params
      if params.is_a?(ActiveSupport::HashWithIndifferentAccess)
        params[:cookie_preferences]
      else
        params.fetch(:cookie_preferences, {}).permit(@resource.cookies.map(&:identifier))
      end
    end

    def initialize_resource
      @resource = ::EuGdpr::CookiePreferences.new(cookie_store: ::EuGdpr::CookieStore.new(send(::EuGdpr::Configuration.cookie_storage)))
    end
  end
end
