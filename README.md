# EuGdpr
Short description and motivation.

## Usage

## Displaying the eu cookie banner

    # app/assets/javascripts/application.js
    //= require eu_gdpr

    # app/assets/javascripts/application.js
    /*
     *= require eu_gdpr
     */

    # app/controllers/application_controller.rb
    helper EuGdpr::ApplicationHelper

    # app/views/layouts/application.html.erb
    <%= eu_gdpr_helper(self).render_cookie_consent_banner(link: eu_gdpr.privacy_policy_path) %>

## Displaying the eu cookie banner anywhere

    # i.e. app/views/some_view.html.haml
    <%= eu_gdpr_helper(self).render_cookie_preferences %>

## Configuring the eu cookie banner

You can configure different levels of cookies in the initializer. The defaults are as follows:

    # config/initializers/eu_gdpr.rb
    config.cookies = ->(cookie_store = ::EuGdpr::CookieStore.new({})) {[
      ::EuGdpr::Cookie.new(identifier: :basic,        adjustable: false, default: true,  cookie_store: cookie_store),
      ::EuGdpr::Cookie.new(identifier: :analytics,    adjustable: true,  default: true,  cookie_store: cookie_store),
      ::EuGdpr::Cookie.new(identifier: :marketing,    adjustable: true,  default: true,  cookie_store: cookie_store),
      ::EuGdpr::Cookie.new(identifier: :social_media, adjustable: true,  default: false, cookie_store: cookie_store)
    ]}

## Registering personal data

```ruby
    EuGdpr.personal_data(Ecm::UserArea::User, log_removals: true, forget_with: :anonymization) do |u|
      u.attribute(:email, anonymize_with: :scrambler)
      u.attribute(:firstname, anonymize_with: :scrambler)
      u.attribute(:lastname, anonymize_with: :scrambler)
      u.attribute(:last_ip, anonymize_with: :nullifier)
      u.association(:posts) do |p|
        p.attribute(:title)
        p.attribute(:body)
        p.association(:gallery) do |g|
          g.attribute(:name)
          g.association(:pictures) do |p|
            p.attribute(:title)
            p.attribute(:asset) { |r| r.base64_encoded_asset }
          end
        end
      end
    end
```

```ruby
    EuGdpr.personal_data(Ecm::Contact::ContactRequest, log_removals: true, forget_with: :deletion) do |r|
      r.attribute(:firstname)
      r.attribute(:lastname)
      r.attribute(:title)
      r.attribute(:body)
    end
```

## How do I show the structure of registered personal data?

    - EuGdpr.personal_data.each do |pd|
      %h2= pd.root
      = ap(pd.to_hash.as_json).html_safe

## Features

* Checks for SSL in production
* Adds sensible attribute log filtering (customizable)
* EU Cookie Message

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails_eu_gdpr'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_eu_gdpr
```

Add the initializer:

```bash
$ rails g rails_eu_gdpr:install
```

## Upgrading to 0.0.3

Remove config.privacy_policy_defaults from config/initializers/eu_gdpr.rb as this options is not needed anymore.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO

* Personal Data Export
* Right to Forget
* Add cookie consent levels (i.e.required, marketing, etc.)

## Unsorted notes

Model::Gdpr::PersonalDataConcern#gdpr_forget!
Model::Gdpr::PersonalDataConcern#gdpr_export(format: :json)

Gdpr::Anonymizer::Base
Gdpr::Anonymizer::Scrambler
Gdpr::Anonymizer::Nullifier
