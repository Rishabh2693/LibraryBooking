class CascadeConstraint < ActiveRecord::Migration[5.0]
  def change
    # remove_foreign_key :bookings, :library_memebers
    # add_foreign_key :bookings, :library_memebers, dependent: :delete
  end
end
