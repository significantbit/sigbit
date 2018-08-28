module Sigbit
  module NodeMethods
    module Tree
      extend ActiveSupport::Concern

      included do
        has_ancestry
        acts_as_list scope: [:ancestry]

        after_save :create_url

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
    end
  end
end
