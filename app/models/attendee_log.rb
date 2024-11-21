class AttendeeLog < ApplicationRecord
  belongs_to :attendee

  validates :description, presence: true
end
