class AddPostponedToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :isPostponed, :boolean
  end
end
