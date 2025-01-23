class Test < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  #validate :can_be_published?

  scope :easy, -> { where(level: (0..1)) }
  scope :middle, -> { where(level: (2..4)) }
  scope :difficult, -> { where(level: (5..Float::INFINITY)) }
  scope :published, -> { where(published: true) }
  scope :by_level, ->(level) { where(level: level) }
  scope :by_category, ->(category) { where(category: category)}
  def self.sort_test_name_by_category(category)
    by_categories(category)
    .order('tests.title DESC')
    .pluck(:title)
  end

  def can_be_published?
    !(questions.empty? || answers.empty?)
  end
end
