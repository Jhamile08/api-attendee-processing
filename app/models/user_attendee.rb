class UserAttendee < ApplicationRecord
  has_many :attendees, dependent: :destroy
  has_many :attendee_rules, dependent: :destroy

  validates :quantity_tickets, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
