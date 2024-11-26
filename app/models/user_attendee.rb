class UserAttendee < ApplicationRecord
  # Relaciones
  has_many :attendees, dependent: :destroy
  has_many :attendee_rules, dependent: :destroy

  # Validaciones
  validates :quantity_tickets,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
