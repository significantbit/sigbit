# Sigbit CMS

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sigbit', github: 'significantbit/sigbit'
```

Also, for now add these gems to the application's Gemfile:

```ruby
gem 'attachinary' , github: 'significantbit/attachinary', branch: 'rails5'

source "https://gems.rapidrailsthemes.com/gems" do
  gem "rrt", "~> 1.1.0"
end
```

Remember to put your Cloudinary config file in the config directory.

And then execute:
```bash
$ bundle
```

