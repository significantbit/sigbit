require "concerns/sigbit/node_methods/relations"

module Sigbit
  class Node < ApplicationRecord
    extend Mobility
    include Sigbit::NodeMethods::Tree
    include Sigbit::NodeMethods::Relations

    translates :menu_title, :url, locale_accessors: true

    validates :menu_title, presence: true

    default_scope { order(position: :asc) }
    scope :visible_in_menu, -> { where(visible_in_menu: true, hidden: false) }
    scope :visible, -> { where(hidden: false) }
    scope :show_in_footer, -> { where(show_in_footer: true, hidden: false) }
    def contentable
      page_type.contentable
    end

    def contentable_icon
      contentable.content_type_icon
    end
  end
end
