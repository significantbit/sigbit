#require 'rrt'
Gem.loaded_specs["sigbit"].dependencies.each do |d|
  require d.name
end
require "cloudinary"
require "attachinary"
require "attachinary/orm/active_record"

module Sigbit
  class Engine < ::Rails::Engine
    isolate_namespace Sigbit

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer "sigbit", before: :load_config_initializers do |app|
      Rails.application.routes.prepend do
        mount Sigbit::Engine, at: "/admin"
        mount Attachinary::Engine => "/attachinary"
      end
    end

    initializer "webpacker.proxy" do |app|
      insert_middleware = begin
                          Sigbit.webpacker.config.dev_server.present?
                        rescue
                          nil
                        end
      next unless insert_middleware

      app.middleware.insert_before(
        0, Webpacker::DevServerProxy, # "Webpacker::DevServerProxy" if Rails version < 5
        ssl_verify_none: true,
        webpacker: Sigbit.webpacker
      )
    end
  end
end
