module Sigbit
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    def create_frontend
      template "initializer.rb", File.join("config/initializers", "sigbit.rb")
    end
  end
end
