class AttendeeRule < ApplicationRecord
  # Relaciones
  belongs_to :user_attendee

  # Validaciones
  validates :event_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user_attendee, presence: true
end
