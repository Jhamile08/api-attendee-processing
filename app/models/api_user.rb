class ApiUser < ApplicationRecord
  has_many :user_attendees, dependent: :destroy
end
