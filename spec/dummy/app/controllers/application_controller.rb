class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'

  include Controller::EuGdpr::CookieConcern
end
