require "sigbit/engine"
require "sigbit/configuration"

module Sigbit
  class << self
    attr_reader :config

    def configure
      @config = Configuration.new
      yield config
    end
  end
end
