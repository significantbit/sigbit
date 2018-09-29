module Sigbit
  class ContentTypeConfigPolicy < ApplicationPolicy
    def show?
      user.has_role?(:developer)
    end

    def new?
      create?
    end

    def create?
      user.has_role?(:developer)
    end

    def edit?
      update?
    end

    def update?
      user.has_role?(:developer)
    end

    def destroy?
      user.has_role?(:developer)
    end
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
