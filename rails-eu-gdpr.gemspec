if RUBY_VERSION < '2.0.0'
  $:.push File.expand_path("../lib", __FILE__)
else
  $:.push File.expand_path("lib", __dir__)
end

# Maintain your gem's version:
require "eu_gdpr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_eu_gdpr"
  s.version     = EuGdpr::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/rails_eu_gdpr"
  s.summary     = "Simple EU GDPR (DSGVO) compliance for rails applications."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency 'awesome_print'
  s.add_dependency 'cookies_eu'

  s.add_development_dependency "sqlite3"
end
