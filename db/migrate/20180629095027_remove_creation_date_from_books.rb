class RemoveCreationDateFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :created_at
  end
end
