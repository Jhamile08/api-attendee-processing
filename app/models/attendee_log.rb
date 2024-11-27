class AttendeeLog < ApplicationRecord
  # Relaciones
  belongs_to :attendee

  # Validaciones
  validates :description, presence: true, length: { maximum: 500 }
  validates :attendee, presence: true
end
