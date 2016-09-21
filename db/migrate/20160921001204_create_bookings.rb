class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :start
      t.datetime :end
      t.references :room, foreign_key: true
      t.references :library_member, foreign_key: true

      t.timestamps
    end
  end
end
