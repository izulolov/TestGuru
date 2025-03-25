class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question, on: :create
  after_create :set_timer
  before_save :check_completion

  def completed?
    current_question.nil? || time_over?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    self.current_question = next_question
    
    # Если тест завершен из-за ответа на последний вопрос, записываем время завершения
    if current_question.nil?
      self.passed = successfully_passed?
      self.end_time = Time.current
    end
    
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
    update_column(:deadline_time, created_at + test.timer.minutes)
  end

  def time_over?
    return false unless test.has_timer? && deadline_time.present?
    Time.current > deadline_time
  end

  def remaining_time
    return nil unless test.has_timer? && deadline_time.present?
    
    remaining = (deadline_time - Time.current).to_i
    remaining.positive? ? remaining : 0
  end

  private

  # Проверяем завершение теста перед сохранением
  def check_completion
    # Если тест завершен из-за истечения времени, но end_time не установлен
    if time_over? && end_time.nil?
      self.passed = successfully_passed?
      self.end_time = Time.current
    end
  end

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
