class Answer < ApplicationRecord
  belongs_to :question
  validates :body, presence: true
  # Для выбора правильных ответов
  scope :right_answer, -> { where(correct: true) }

end
