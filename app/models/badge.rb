class Badge < ApplicationRecord
  belongs_to :user
  RULES = { all_tests_backend: 'Все тесты из категории Backend',
          first_attempt: 'Успешное прохождение теста с первой попытки',
          specific_level: 'Успешное прохождение тестов из уровня 1' }.freeze
end
