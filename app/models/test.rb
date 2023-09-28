class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :user_tests
  has_many :users, through: :user_tests

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: (0..1)) }
  scope :middle, -> { where(level: (2..4)) }
  scope :difficult, -> { where(level: (5..Float::INFINITY)) }
  scope :sort_by_categories, ->(category) {
    joins(:category)
    .where(categories: { title: category })
  }

  def self.sort_test_name_by_category(category)
    sort_by_categories(category)
    .order('tests.title DESC')
    .pluck(:title)
  end
end
