class Attendee < ApplicationRecord
  belongs_to :user_attendee
  has_many :attendee_logs, dependent: :destroy
  #belongs_to :event // For the optinal test model

  #Validations
  validates :name, presence: true, length: {minimum:2, maximum:50}
  validates :email, presence: true, length: {maximum:30}

  #Enums
  enum status: { pending: 0, confirmed: 1, cancel: 2 }
end
