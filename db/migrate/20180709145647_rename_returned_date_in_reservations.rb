class RenameReturnedDateInReservations < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :returned_at, :returned_date
  end
end
