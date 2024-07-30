class Badge < ApplicationRecord
  has_many :user_badges
  has_many :user, through: :user_badges

  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :image_url, presence: true, length: { minimum: 10 }
  validates :rule, presence: true

  RULES = { all_tests_backend: 'Все тесты из категории Backend',
          first_attempt: 'Успешное прохождение теста с первой попытки',
          all_tests_level_one: 'Успешное прохождение тестов из уровня 1' }.freeze
end
