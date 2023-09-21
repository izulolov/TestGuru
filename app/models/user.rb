class User < ApplicationRecord

  # Две has_many ниже на замену has_and_belongs_to_many :users
  # has_and_belongs_to_many :users хочет таблицу tests_users,
  # однако я решил использовать уже созданную таблицу user_tests.
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :author_tests, class_name: 'Test'
  
  # has_and_belongs_to_many :tests

  # Тесты по уровню
  def tests_by_level(test_level)
    tests.where(level: test_level)
  end
end
