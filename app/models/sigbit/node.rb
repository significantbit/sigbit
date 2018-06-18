require "concerns/sigbit/node_methods/relations"

module Sigbit
  class Node < ApplicationRecord
    extend Mobility
    include Sigbit::NodeMethods::Tree
    include Sigbit::NodeMethods::Relations

    translates :menu_title, :url, fallbacks: { sv: :en }, locale_accessors: true

    def contentable
      page_type.contentable
    end
  end
end
