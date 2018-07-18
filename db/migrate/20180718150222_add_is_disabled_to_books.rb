class AddIsDisabledToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :isDisabled, :boolean
  end
end
