class AddPostponeCounterToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :postpone_counter, :integer
  end
end
