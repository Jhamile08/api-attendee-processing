class AttendeeLog < ApplicationRecord
  belongs_to :attendee

  #Validations
  validates :description, length: {minimum: 3, maximum: 50}
end
