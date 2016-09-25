class Room < ApplicationRecord
  has_many :bookings, :dependent => :delete_all
end
