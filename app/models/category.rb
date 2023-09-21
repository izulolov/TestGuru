class Category < ApplicationRecord
  has_many :tests
  validates :title, presence: true

  # scope-метод по умолчанию для получения Категорий
  default_scope {order(title: :asc)}

end
