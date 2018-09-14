class AddPublishedOnOnSigbitNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :sigbit_nodes, :published_on, :datetime
  end
end
