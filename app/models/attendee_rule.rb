class AttendeeRule < ApplicationRecord
  belongs_to :user_attendee

  validates :event_id, :title, :description, presence: true
end
