class UserAttendee < ApplicationRecord
  belongs_to :api_user
  has_many :attendees, dependent: :destroy
  has_many :attendee_rules, dependent: :destroy
end
