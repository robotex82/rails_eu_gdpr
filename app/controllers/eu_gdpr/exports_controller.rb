module EuGdpr
  class ExportsController < EuGdpr::Configuration.base_controller.constantize
    include ResourcesController::Resources
    include ResourcesController::ResourceInflections
    include ResourcesController::RestResourceUrls
    include ResourcesController::RestActions
    include ResourcesController::LocationHistory

    helper Rails::AddOns::TableHelper

    def self.resource_class
      EuGdpr::Export
    end

    private

    def load_resource
      super
      # @resource = load_resource_scope.find(params[:id])
    end

    def permitted_params
      params.require(resource_class.name.demodulize.underscore.to_sym).permit()
    end
  end
end