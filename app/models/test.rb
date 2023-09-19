class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_and_belongs_to_many :users

  def self.sort_categories(category)
    Test.joins('JOIN categories ON categories.id=tests.category_id')
    .where('categories.title =?', category)
    .order('tests.title DESC')
    .pluck(:title)
  end
end
