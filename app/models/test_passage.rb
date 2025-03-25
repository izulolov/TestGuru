class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question, on: :create
  after_create :set_timer

  def completed?
    current_question.nil? || time_over?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    self.current_question = next_question
    save!
  end

  def percent_correct
    ((correct_questions.to_f / count_questions) * 100).round(2)
  end

  def count_questions
    test.questions.count
  end

  def successfully_passed?
    percent_correct >= 85
  end

  def current_question_possition
    return 1 unless current_question.present?
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end
  
  # Методы для работы с таймером
  def set_timer
    return unless test.has_timer?
    update(end_time: created_at + test.timer.minutes)
  end

  def time_over?
    return false unless test.has_timer? && end_time.present?
    Time.current > end_time
  end

  def remaining_time
    return nil unless test.has_timer? && end_time.present?
    
    remaining = (end_time - Time.current).to_i
    remaining.positive? ? remaining : 0
  end

  private

  def before_validation_set_question
    if new_record?
      self.current_question = test.questions.first
    else
      self.current_question = next_question
    end
  end

  def correct_answer?(answer_ids)
    return false if answer_ids.nil?
    
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.right_answer
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
