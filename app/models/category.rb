class Category < ApplicationRecord
  acts_as_nested_set

  has_many :category_options
  has_many :products
end
