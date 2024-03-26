require 'digest/sha1'

class User < ApplicationRecord
  
  include Auth

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, class_name: 'Test'

  def tests_by_level(test_level)
    tests.where(level: test_level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

end
