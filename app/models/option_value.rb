class OptionValue < ApplicationRecord
  acts_as_list scope: :category_option_id

  belongs_to :category_option, inverse_of: :option_values
  has_one :page_click, as: :clickable

  #表示某一个分类下的任意option_value
  def self.any_option_value( category_option)
    new( category_option: category_option, title: '不限', id: 0)
  end
end
