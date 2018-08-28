class CreateSigbitNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :sigbit_nodes do |t|
      t.integer :position, default: 1, null: false
      t.jsonb :translations, default: {}
      t.string :ancestry
      t.datetime :published_at
      t.boolean :hide_in_menus, default: false
      t.timestamps
    end
    add_index :sigbit_nodes, :ancestry
  end
end
