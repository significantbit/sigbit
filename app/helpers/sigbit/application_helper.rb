module Sigbit
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Sigbit.webpacker
    end

    def app_name
      "Default sigbit site"
    end
  end
end
