class Answer < ApplicationRecord
  belongs_to :question
  validates :body, presence: true
  validate :answer_limit

  scope :right_answer, -> { where(correct: true) }

  private

  def answer_limit
    errors.add(:question, 'Ответов не должно быть больше 4') if question.answers.count >= 4
  end
end
