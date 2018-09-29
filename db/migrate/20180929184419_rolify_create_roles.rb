class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:sigbit_roles) do |t|
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps
    end

    create_table(:sigbit_users_sigbit_roles, id: false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:sigbit_roles, [ :name, :resource_type, :resource_id ])
    add_index(:sigbit_users_sigbit_roles, [ :user_id, :role_id ])
  end
end
