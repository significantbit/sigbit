$LOAD_PATH.push File.expand_path('../lib', __FILE__)

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
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "jquery-rails", "~> 4.3.3"
  s.add_dependency "acts_as_list", "~> 0.9.16"
  s.add_dependency "hamlit-rails", "~> 0.2.0"
  s.add_dependency "mobility", "~> 0.6.0"
  s.add_dependency "simple_form", "~> 4.0.1"
  s.add_dependency 'devise', ">= 4.5", "< 4.8"
  s.add_dependency 'cocoon', '~> 1.2.11'
  s.add_dependency 'wysiwyg-rails', '~> 2.8.5'
  s.add_dependency 'kaminari', '~> 1.1.1'
  s.add_dependency 'momentjs-rails', '~> 2.20.1'
  s.add_dependency 'bootstrap4-datetime-picker-rails', '~> 0.1.8'
  s.add_dependency 'ancestry', '~> 3.0.2'
  s.add_dependency 'cloudinary', '~> 1.9.1'
  s.add_dependency 'rails-i18n', '~> 5.1.1'
  s.add_dependency "publishable", '~> 1.0.4'
  s.add_dependency 'meta-tags', '~> 2.10.0'
  s.add_development_dependency "pg", '~> 1.0'
end
