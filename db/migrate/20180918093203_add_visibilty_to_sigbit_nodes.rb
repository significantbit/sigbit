class AddVisibiltyToSigbitNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :sigbit_nodes, :visible_in_menu, :boolean, default: true
    add_column :sigbit_nodes, :hidden, :boolean, default: false
    add_column :sigbit_nodes, :show_in_footer, :boolean, default: false
  end
end
