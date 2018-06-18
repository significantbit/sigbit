module Sigbit
  class NewNodeForm < FormObject
    attr_accessor(
      :id,
      :menu_title,
      :contentable_type,
      :parent_id
    )

    validates :menu_title, presence: true
    validates :contentable_type, presence: true

    def persisted?
      false
    end

    def save
      return false unless valid?
      @id = Sigbit::Node.create! do |node|
        node.parent_id = @parent_id
        node.menu_title = @menu_title
        node.url_en = "dummy"
        node.url_sv = "dummy"
        node.url_fr = "dummy"
        node.page_type = Sigbit::PageType.new do |page_type|
          page_type.contentable = @contentable_type.constantize.new
        end
      end
    end

    def self.model_name
      ActiveModel::Name.new(self, nil, "Node")
    end
  end
end
