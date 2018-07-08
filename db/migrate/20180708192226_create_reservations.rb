class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :request_date
      t.date :expiration_date
      t.string :isReturned
      t.string :boolean
      t.string :isLoan
      t.string :boolean

      t.timestamps
    end
  end
end
