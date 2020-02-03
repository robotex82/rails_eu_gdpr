class ApplicationController < ActionController::Base
  view_helper EuGdpr::ApplicationViewHelper, as: :eu_gdpr_helper
end
