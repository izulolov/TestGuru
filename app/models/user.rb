class User < ApplicationRecord

  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :author_tests, class_name: 'Test'

  validates :name, :email, presence: true

  def tests_by_level(test_level)
    tests.where(level: test_level)
  end
end
