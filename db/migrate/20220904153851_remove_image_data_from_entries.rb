class RemoveImageDataFromEntries < ActiveRecord::Migration[6.1]
  def change
    remove_column :entries, :image_data, :text
  end
end
