namespace :sigbit do
  namespace :webpacker do
    desc "Install deps with yarn"
    task :yarn_install do
      Dir.chdir(File.join(__dir__, "../..")) do
        system "yarn install --no-progress --production"
      end
    end

    desc "Compile JavaScript packs using webpack for production with digests"
    task compile: [:yarn_install, :environment] do
      Webpacker.with_node_env("production") do
          if Sigbit.webpacker.commands.compile
            puts "Compile ok."
            # Successful compilation!
          else
            puts "Compile error."
            # Failed compilation
            exit!
          end
      end
    end
  end
end
