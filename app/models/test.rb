class Test < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  belongs_to :category
  has_many :questions, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :user_id

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
