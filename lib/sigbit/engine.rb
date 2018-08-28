Gem.loaded_specs["sigbit"].dependencies.each do |d|
  require d.name
end

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
      end
    end
  end
end
