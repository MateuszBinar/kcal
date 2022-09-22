class AddCommentToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :comment, :string
  end
end
