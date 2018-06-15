module Sigbit
  module NodeMethods
    module Tree
      extend ActiveSupport::Concern

      included do
        has_ancestry
        acts_as_list scope: [:ancestry]
      end
    end
  end
end
