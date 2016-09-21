class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :library_member
end
