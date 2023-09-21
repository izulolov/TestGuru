class Answer < ApplicationRecord
  belongs_to :question

  # Для выбора правильных ответов
  scope :right_answer, -> { where(correct: true) }

end
