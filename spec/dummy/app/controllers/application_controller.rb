class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'

  # include Controller::EuGdpr::CookieConcern
  view_helper EuGdpr::ApplicationViewHelper, as: :eu_gdpr_helper
end
