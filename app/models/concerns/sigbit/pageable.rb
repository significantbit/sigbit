module Sigbit
  module Pageable
    extend ActiveSupport::Concern
    included do
      has_many :blocks, -> { order(position: :asc) }, as: :pageable, dependent: :destroy
      accepts_nested_attributes_for :blocks, allow_destroy: true
    end

    # def showing_submenu
    #   blocks.where(visible_in_submenu: true).size > 0
    # end

    def block_data
      content = []
      blocks.each do |b|
        content << b.blockable.searchable_data.join(" ")
      end
      content.join(" ")
    end
  end
end
