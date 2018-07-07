class ChangeReleaseDateType < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :released_at
    add_column :books, :released_at, :integer
  end
end
