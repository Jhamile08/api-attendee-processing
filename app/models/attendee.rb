class Attendee < ApplicationRecord
  belongs_to :user_attendee

  has_many :attendee_logs, dependent: :destroy

  validates :ticket_id, :name, :email, presence: true
  validates :status, inclusion: { in: [true, false] }

  belongs_to :user_attendee
end
