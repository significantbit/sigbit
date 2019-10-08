module Sigbit
  class PageType < ApplicationRecord
    belongs_to :node, class_name: "Sigbit::Node", touch: true
    belongs_to :contentable, polymorphic: true, dependent: :destroy
    accepts_nested_attributes_for :contentable
  end
end
