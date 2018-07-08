class AddBookToReservations < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :book, foreign_key: true
  end
end
