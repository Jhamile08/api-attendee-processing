class Attendee < ApplicationRecord
  # Relaciones
  has_many :attendee_logs, dependent: :destroy

  # Validaciones
  validates :ticket_id, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: [true, false], message: 'must be true or false' }
end
