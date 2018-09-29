module Sigbit
  class Nodes::PublishPolicy < ApplicationPolicy
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
