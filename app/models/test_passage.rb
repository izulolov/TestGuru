class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  # Константа для минимального процента успешного прохождения теста
  SUCCESSFUL_PASSING_PERCENT = 85

  before_validation :before_validation_set_question, on: %i[create update]
  before_validation :set_timer, on: :create
  before_update :passed?, if: :completed?

  def completed?
    current_question.nil? || time_over?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!

    # Явно вызываем сервис награждения, если тест завершен и успешно пройден
    if successfully_passed?
      BadgeService.new(user, test).award_badges
    end
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
  
  # Инициализация таймера при старте теста
  def set_timer
    if test.timer_enabled?
      self.started_at = Time.current
      self.expires_at = started_at + test.timer.minutes
    end
  end

  # Проверка, истекло ли время на прохождение теста
  def time_over?
    test.timer_enabled? && expires_at.present? && Time.current > expires_at
  end

  # Расчет оставшегося времени в секундах
  def remaining_time
    return unless test.timer_enabled? && expires_at.present?
    
    (expires_at - Time.current).to_i.positive? ? (expires_at - Time.current).to_i : 0
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
