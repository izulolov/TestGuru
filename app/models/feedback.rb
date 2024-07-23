class Feedback < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { minimum: 20 }
end
