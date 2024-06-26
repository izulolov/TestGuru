class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question, on: %i[create update]

  def completed?
    current_question.nil?
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
    percent_correct >= 85 ? true : false
  end

  def current_question_possition
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  private

  def before_validation_set_question
    self.current_question = next_question
  end

  # Выдается ошибка если вопрос без ответов
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
end
