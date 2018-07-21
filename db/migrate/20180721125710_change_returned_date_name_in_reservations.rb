class ChangeReturnedDateNameInReservations < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :returned_date, :return_date
  end
end
