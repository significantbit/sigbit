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

    def save
      return false unless valid?
      @id = Sigbit::Node.create! do |node|
        node.parent_id = @parent_id

        node.published_at = DateTime.now
        I18n.available_locales.each do |l|
          node.send("menu_title_#{l}=", @menu_title)
          node.send("url_#{l}=", "dummy")
        end
        node.page_type = Sigbit::PageType.new do |page_type|
          page_type.contentable = @contentable_type.constantize.new
        end
      end
    end
  end
end
