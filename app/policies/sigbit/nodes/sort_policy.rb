module Sigbit
  class Nodes::SortPolicy < ApplicationPolicy
    def update?
      user.has_role?(:admin)
    end
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
