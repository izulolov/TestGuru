class Badge < ApplicationRecord
  has_many :user_badges
  has_many :user, through: :user_badges

  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :image_url, presence: true, length: { minimum: 10 }
  validates :rule, presence: true

  RULES = {
    all_tests_of_some_category: 'За успешное прохождение всех тестов из категории * ',
    first_attempt: 'За успешное прохождение теста с первой попытки',
    all_tests_of_some_level: 'За успешное прохождение всех тестов уровня *'
  }.freeze
end
