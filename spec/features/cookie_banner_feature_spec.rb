require 'rails_helper'

RSpec.describe 'Cookie Banner', type: :feature, js: true do
  before(:each) do
    visit '/'
  end

  it { binding.pry; expect(page.body).to have_css('#cookies-eu-modal') }
end