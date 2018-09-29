module Sigbit
  class NodePolicy < ApplicationPolicy
    def index?
      user.has_role?(:admin)
    end

    def new?
      create?
    end

    def create?
      user.has_role?(:admin)
    end

    def edit?
      update?
    end

    def update?
      user.has_role?(:admin)
    end

    def destroy?
      user.has_role?(:admin)
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
