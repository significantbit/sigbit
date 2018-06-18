$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "sigbit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sigbit"
  s.version     = Sigbit::VERSION
  s.authors     = ["Johan André"]
  s.email       = ["johan@significantbit.se"]
  s.homepage    = "https://www.sigbit.se"
  s.summary     = "Summary of Sigbit."
  s.description = "Description of Sigbit."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "sass-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap", "~> 4.1"
  s.add_dependency "acts_as_list"
  s.add_dependency "ancestry"
  s.add_dependency "hamlit-rails"
  s.add_dependency "mobility", "~> 0.6.0"
  s.add_dependency "simple_form"
  s.add_dependency 'material_icons'
  s.add_dependency 'font-awesome-sass', '~> 5.0.13'
  s.add_development_dependency "pg"
end
