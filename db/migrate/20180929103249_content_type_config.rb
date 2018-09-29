class ContentTypeConfig < ActiveRecord::Migration[5.2]
  def change
    create_table :sigbit_content_type_configs do |t|
      t.text :data, default: "{}"
    end
  end
end
