class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :request_date
      t.date :expiration_date
      t.string :isReturned
      t.boolean :isLoan
      t.boolean :isReturned

      t.timestamps
    end
  end
end
