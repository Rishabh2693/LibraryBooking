class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :library_member
  attr_accessor :emails
  validate :start_and_end_date_validation, :end_date_validation, :no_of_hours, :start_date_validation
  def start_and_end_date_validation
    if self.start > self.end
      errors.add(:start, "time should be less than End time")
    end
  end
  def start_date_validation
    if self.start < DateTime.now() - 4.hours
      errors.add(:start, "time should greater than current time")
    end
  end
  def no_of_hours
    if ((self.end - self.start) / 1.hour).round > 2.hour
      errors.add(:start, "You cannot book room for more than 2 hours")
    end
  end
  def end_date_validation
    if self.end > 7.days.from_now - 4.hours
      errors.add(:booking, "time should be less than 7 days")
    end
  end
end
