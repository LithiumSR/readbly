class AddReturnedDateToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :returned_at, :date
  end
end
