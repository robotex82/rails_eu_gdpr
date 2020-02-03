Rails.application.routes.draw do
  mount EuGdpr::Engine, at: "/"

  root to: 'home#index'
end
