class ChangeRemoveDatetimeFromBook < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :created_at, :date
    change_column :books, :released_at, :date
  end
end
