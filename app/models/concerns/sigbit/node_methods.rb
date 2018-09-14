module Sigbit
  module NodeMethods
    extend ActiveSupport::Concern

    included do

      has_one :page_type,
              class_name: "Sigbit::PageType",
              dependent: :destroy
      accepts_nested_attributes_for :page_type
      has_one :contentable, through: :page_type
    end
  end
end
