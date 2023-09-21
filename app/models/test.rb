class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  # Две has_many ниже на замену has_and_belongs_to_many :users
  # has_and_belongs_to_many :users хочет таблицу tests_users,
  # однако я решил использовать уже созданную таблицу user_tests.
  has_many :user_tests
  has_many :users, through: :user_tests
  # has_and_belongs_to_many :users

  # Сортировать по категории
  def self.sort_categories(category)
    Test.joins('JOIN categories ON categories.id=tests.category_id')
    .where('categories.title =?', category)
    .order('tests.title DESC')
    .pluck(:title)
  end
end
