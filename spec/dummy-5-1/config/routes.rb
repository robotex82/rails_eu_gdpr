Rails.application.routes.draw do
  mount EuGdpr::Engine => "/eu_gdpr"
end
