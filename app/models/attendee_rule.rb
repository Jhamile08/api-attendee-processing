class AttendeeRule < ApplicationRecord
  belongs_to :user_attendee
  #belongs_to :event // For the optinal test model

  #Validations
  validates :title, presence: true, length: {minimum:3, maximum:50}
  validates :description, presence: true, length: {maximum:500}
end
