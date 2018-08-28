class CreateSigbitPageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :sigbit_page_types do |t|
      t.belongs_to :node, foreign_key: { to_table: :sigbit_nodes }
      t.belongs_to :contentable, polymorphic: true

      t.timestamps
    end
  end
end
