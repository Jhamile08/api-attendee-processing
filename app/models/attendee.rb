class Attendee < ApplicationRecord
  belongs_to :user_attendee

  has_many :attendee_logs, dependent: :destroy

  validates :ticket_id, :name, :email, presence: true
  validates :status, inclusion: { in: [true, false] }

  belongs_to :user_attendee

  # Custom Validation
  validate :already_canceled, on: :update

  private

  # Error if trying to cancel if is already canceled
  def already_canceled
    if !status 
      errors.add(:status, "cannot be canceled because it is already canceled") unless status_was
    end
  end
end
