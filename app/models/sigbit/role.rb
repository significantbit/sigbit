  module Sigbit
    class Role < Sigbit::ApplicationRecord
      has_and_belongs_to_many :sigbit_users, join_table: :sigbit_users_sigbit_roles


      belongs_to :resource,
                 polymorphic: true,
                 optional: true


      validates :resource_type,
                inclusion: { in: Rolify.resource_types },
                allow_nil: true

      scopify
    end
end
