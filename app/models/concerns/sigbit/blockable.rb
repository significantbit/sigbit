module Sigbit
  module Blockable
    extend ActiveSupport::Concern

    included do
      has_one :block, as: :blockable, dependent: :destroy

      def to_s
        I18n.t(self.class.to_s.underscore, scope: "activerecord.models", count: 1)
      end

      def to_partial_path
        self.class.to_s.underscore
      end
    end

    def self.included_in
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.select { |c| c.included_modules.include?(Blockable) }.sort { |x, y| x.to_s <=> y.to_s }
    end

    def self.sorted_block_hash
      blocks_hash = Hash.new
      Blockable.included_in.each do |block|
        blocks_hash[I18n.t(block.model_name.to_s.underscore, scope: "activerecord.models", count: 1)] = block
      end
      blocks_hash.sort
    end

    class_methods do
      def search_attributes(*args)
        define_method :searchable_data do
          args.map { |x| ActionView::Base.full_sanitizer.sanitize(self.send(x)) }
        end
      end

      def block_title_field(field)
        define_method :title_field do
          self.send(field)
        end
      end
    end

    def searchable_data
      []
    end

    def title_field
      ""
    end
    end
end
