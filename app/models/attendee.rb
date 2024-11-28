class Attendee < ApplicationRecord
  # Relaciones
  has_many :attendee_logs, dependent: :destroy
  belongs_to :user_attendee

  # Custom Validation
  validate :already_canceled, on: :update

  private

  # Error if trying to cancel if is already canceled
  def already_canceled
    return if status

    errors.add(:status, 'cannot be canceled because it is already canceled') unless status_was
  end

  # Validaciones
  validates :ticket_id, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: [true, false], message: 'must be true or false' }
end
