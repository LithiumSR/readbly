class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :overview
      t.string :isbn
      t.datetime :created_at
      t.datetime :released_at
      t.string :coverlink

      t.timestamps
    end
  end
end
