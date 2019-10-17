module Sigbit
  module Contentable
    extend ActiveSupport::Concern

    def self.included_in
      Rails.application.eager_load! if Rails.env.development?
      ActiveRecord::Base.descendants.select { |c| c.included_modules.include?(Sigbit::Contentable) }.sort { |x, y| x.to_s <=> y.to_s }
    end

    included do
      has_one :page_type, as: :contentable, class_name: "Sigbit::PageType", dependent: :destroy
      has_one :node, through: :page_type

      def to_partial_path
        self.class.to_s.underscore
      end
    end

    class_methods do
      def has_icon(icon)
        define_method :content_type_icon do
          icon
        end
      end

      def mountable_in_tree?
        true
      end

      def search_attributes(*args)
        define_method :searchable_data do
          args.map { |x| ActionView::Base.full_sanitizer.sanitize(self.send(x)) }
        end
      end

      def search_description(data)
        define_method :brief_description do
          ActionView::Base.full_sanitizer.sanitize(self.send(data))
        end
      end

    end

    def title
      translations.dig(I18n.default_locale, :title) || node.translations.dig(I18n.default_locale, :menu_title)
    end

    def content_type_icon
      "flag"
    end

    def brief_description
      ""
    end

    def searchable_data
      []
    end

    def should_show_up_in_menus
      true
    end
  end
end
