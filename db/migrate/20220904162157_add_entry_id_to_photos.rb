class AddEntryIdToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :entry_id, :integer
  end
end
