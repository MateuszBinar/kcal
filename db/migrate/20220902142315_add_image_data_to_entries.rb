class AddImageDataToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :image_data, :text
  end
end
