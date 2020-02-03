class HomeController < ApplicationController
  def index
    render inline: '<h1>home#index</h1>', layout: 'application'
  end
end
