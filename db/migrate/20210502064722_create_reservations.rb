class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest
      t.date :start_date
      t.date :end_date
      t.float :payout_price
      t.float :security_price
      t.float :total_price
      t.string :currency
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status

      t.timestamps
    end
  end
end
