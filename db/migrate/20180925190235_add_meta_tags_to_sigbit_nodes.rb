class AddMetaTagsToSigbitNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :sigbit_nodes, :meta_keywords, :text
    add_column :sigbit_nodes, :meta_description, :text
  end
end
