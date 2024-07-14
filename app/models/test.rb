class Test < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: (0..1)) }
  scope :middle, -> { where(level: (2..4)) }
  scope :difficult, -> { where(level: (5..Float::INFINITY)) }
  scope :sort_by_categories, ->(category) {
    joins(:category)
    .where(categories: { title: category }) }
  scope :with_questions_and_answers, -> {
    includes(:questions, questions: :answers)
    .where('EXISTS (SELECT 1 FROM questions WHERE questions.test_id = tests.id LIMIT 1)')
    .where('EXISTS (SELECT 1 FROM answers WHERE answers.question_id IN (SELECT id FROM questions WHERE questions.test_id = tests.id) LIMIT 1)')
  }
  scope :published?, -> { where(published: true) }
  def self.sort_test_name_by_category(category)
    sort_by_categories(category)
    .order('tests.title DESC')
    .pluck(:title)
  end
end
