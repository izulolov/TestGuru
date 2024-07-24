class Badge < ApplicationRecord
  has_many :user_badges
  has_many :user, through: :user_badges
  RULES = { all_tests_backend: 'Все тесты из категории Backend',
          first_attempt: 'Успешное прохождение теста с первой попытки',
          specific_level: 'Успешное прохождение тестов из уровня 1' }.freeze
end
