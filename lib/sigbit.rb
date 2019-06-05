require "sigbit/engine"
require "sigbit/configuration"

module Sigbit
  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))
  class << self
    attr_reader :config

    def configure
      @config = Configuration.new
      yield config
    end

    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join("config/webpacker.yml")
      )
    end
  end
end
