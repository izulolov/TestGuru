class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question, on: %i[create update]
  after_update :receiving_award_badge, if: :successfully_passed?
  after_update :passed_all_tests_level_one, if: :successfully_passed?
  after_update :passed_all_backend_tests?, if: :completed?
  
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
    percent_correct >= 85 ? (change_passed_bool && true) : false
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

  def receiving_award_badge
    Badge.all.each do |badge|
      check_badge_rule(badge) && user.badges << badge
    end
  end

  def check_badge_rule(badge)
    case badge.rule
    when 'first_attempt'
      first_attempt?
    when 'all_tests_level_one'
      passed_all_tests_level_one
    when 'all_tests_backend'
      passed_all_backend_tests?
    else
      false
    end
  end

  def first_attempt?
    user.test_passages.where(test: test).count == 1
  end

  def passed_all_tests_level_one
    user.tests.where(level: 1).count == user.tests.where(level: 1, passed: true).count
  end

  def passed_all_backend_tests?
    backend_category = Category.find_by(title: 'Backend')
    user.tests.where(category: backend_category).count { |test| test.passed == true } == test.where(categoty: backend_category).count
  end

  def change_passed_bool
    test.update(passed: true)
  end
end
