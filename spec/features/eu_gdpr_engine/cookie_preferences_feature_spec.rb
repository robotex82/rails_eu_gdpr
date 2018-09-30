require 'rails_helper'

RSpec.describe '/de/cookie_preferences/edit', type: :feature, js: true do
  let(:base_path) { '/de/cookie_preferences' }
  let(:edit_path) { "#{base_path}/edit" }

  describe 'ui' do
    before(:each) { visit(edit_path) }

    it { expect(current_path).to eq(edit_path) }
  end

  describe 'defaults' do
    let(:cookie_store) { ::EuGdpr::CookieStore.new({}) }
    before(:each) do
      ::EuGdpr::Configuration.cookies = ->(cookie_store) do
      [
        ::EuGdpr::Cookie.new(identifier: :basic,        adjustable: false, default: true,  cookie_store: cookie_store),
        ::EuGdpr::Cookie.new(identifier: :analytics,    adjustable: true,  default: true,  cookie_store: cookie_store),
        ::EuGdpr::Cookie.new(identifier: :marketing,    adjustable: true,  default: true,  cookie_store: cookie_store),
        ::EuGdpr::Cookie.new(identifier: :social_media, adjustable: true,  default: false, cookie_store: cookie_store)
      ]
      end
      visit(edit_path)
    end
    
    it { expect(page).to have_field('cookie_preferences_basic', disabled: true) }
    it { expect(page.find("input#cookie_preferences_basic")).to be_checked }
    it { expect(page.find("input#cookie_preferences_basic")).to be_checked }
    it { expect(page.find("input#cookie_preferences_analytics")).to be_checked }
    it { expect(page.find("input#cookie_preferences_marketing")).to be_checked }
    it { expect(page.find("input#cookie_preferences_social_media")).not_to be_checked }
  end

  describe 'enabling a cookie' do
    let(:sucess_message) { I18n.t('eu_gdpr.cookie_preferences.update.success') }
    let(:cookie_store) { ::EuGdpr::CookieStore.new({}) }
    before(:each) do
      ::EuGdpr::Configuration.cookies = ->(cookie_store) do
      [
        ::EuGdpr::Cookie.new(identifier: :basic, adjustable: true, default: false,  cookie_store: cookie_store)
      ]
      end
      visit(edit_path)
    end
    
    it do
      # First make sure we have
      expect(page).to have_field('cookie_preferences_basic')
      expect(page.find("input#cookie_preferences_basic")).not_to be_checked

      # Check and submit
      page.find("input#cookie_preferences_basic").set(true)
      within('#new_cookie_preferences') { find("input[type='submit']").click }

      # Check result
      expect(current_path).to eq(edit_path)
      expect(page.body).to include(sucess_message)

      expect(page.find("input#cookie_preferences_basic")).to be_checked
    end
  end
end
