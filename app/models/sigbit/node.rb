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

    def available_content_types
      ctc = Sigbit::ContentTypeConfig.first.data
      ctc[contentable.class.to_s]
    end

    def link_to_page
      request = Sigbit::Current.request
      [
        request.protocol,
        request.subdomains[0].present? ? "#{request.subdomains[0]}." : nil,
        request.domain,
        Rails.env.development? ? ":#{request.port}" : nil,
        "/",
        I18n.locale,
        url
      ].join("")
    end

    def to_meta_tags
      {
        site: Sigbit::config.app_name,
        reverse: true,
        title: contentable.title.present? ? contentable.title : menu_title,
        keywords: meta_keywords.present? ? meta_keywords : Sigbit::config.default_meta_keywords,
        description: meta_description.present? ? meta_description : Sigbit::config.default_meta_description,
      }
    end
  end
end
