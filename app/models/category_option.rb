class CategoryOption < ApplicationRecord
  belongs_to :category
  #添加 option_values， 取得id
  has_many :option_values
  serialize :values, JSON

end
