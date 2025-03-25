class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  scope :passed, -> { where(passed: true) }
  
  # Константа для минимального процента успешного прохождения теста
  SUCCESSFUL_PASSING_PERCENT = 85

  before_validation :before_validation_set_question, on: %i[create update]
  before_update :passed?, if: :completed?

  def completed?
    current_question.nil?
  end

  # Новый метод для проверки завершения и награждения. вызову в контроллере
  def check_completion
    if completed? && successfully_passed?
      BadgeService.new(self).award_badges
    end
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def percent_correct
    ((correct_questions.to_f / count_questions) * 100).round(2)
  end

  def count_questions
    test.questions.count
  end

  def successfully_passed?
    percent_correct >= SUCCESSFUL_PASSING_PERCENT
  end

  def current_question_possition
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  private

  def before_validation_set_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.right_answer
  end

  def next_question
    if new_record?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def passed?
    self.passed = successfully_passed?
  end
end
