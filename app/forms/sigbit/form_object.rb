module Sigbit
  class FormObject
    include ActiveModel::Model
    def persisted?
      false
    end

    def self.model_name
      ActiveModel::Name.new(self, nil, "Node")
    end
  end
end
