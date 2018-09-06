module Sigbit
  module NodeMethods
    module Tree
      extend ActiveSupport::Concern



      included do
        has_ancestry
        acts_as_list scope: [:ancestry]

        after_save :create_url

        def self.json_tree(nodes)
          nodes.map do |node, sub_nodes|
            {
              id: node.id,
              title: node.menu_title,
              position: node.position,
              ancestry: node.ancestry,
              #published: node.published?,
              type: node.page_type.contentable_type,
              icon: "fa-#{node.page_type.contentable.content_type_icon}",
              contentable: node.page_type.contentable,
              children: Sigbit::Node.json_tree(sub_nodes).compact
            }
          end
        end

        def self.all_of_type(type = nil)
          klass = "ContentType::#{type.to_s.classify}"
          Sigbit::Node.joins(:page_type).where(page_types: { contentable_type: klass })
        end

        def self.all_of_type_not(type = nil)
          klass = "ContentType::#{type.to_s.classify}"
          Sigbit::Node.joins(:page_type).where.not(page_types: { contentable_type: klass })
        end

        def url_friendly_slug
          menu_title.parameterize
        end

        def create_url
          I18n.available_locales.each do |l|
            Mobility.with_locale(l.to_sym) do
              list = (ancestors + [self])
              temp_url = "/" + list.reject(&:root?).map(&:url_friendly_slug).join("/")
              old_translations = translations.deep_dup
              old_translations[Mobility.locale.to_sym][:url] = temp_url
              update_column(:translations, old_translations)
              descendants.each do |d|
                d.create_url
              end
            end
          end
        end
      end

      def all_children_of_type(type = nil)
        klass = symbol_to_class_name(type)
        children.joins(:page_type).where(sigbit_page_types: { contentable_type: klass })
      end

      def all_children_not_of_type(type = nil)
        klass = symbol_to_class_name(type)
        children.joins(:page_type).where.not(sigbit_page_types: { contentable_type: klass })
      end

      def all_descendants_of_type(type = nil)
        klass = symbol_to_class_name(type)
        descendants.joins(:page_type).where(sigbit_page_types: { contentable_type: klass })
      end

      def all_siblings_of_type(type = nil)
        klass = symbol_to_class_name(type)
        siblings.joins(:page_type).where(sigbit_page_types: { contentable_type: klass })
      end

      private

        def symbol_to_class_name(type)
          "ContentType::#{type.to_s.classify}"
        end
    end
  end
end
