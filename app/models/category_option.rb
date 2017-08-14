class CategoryOption < ApplicationRecord
  acts_as_list
  PRODUCT_FILTER_COLUMN_NAMES = ['filt0','filt1','filt2','filt3','filt4','filt5','filt6','filt7','filt8','filt9']
  belongs_to :category
  #添加 option_values， 取得id
  has_many :option_values, dependent: :delete_all

  validates :category, acceptance: true

  before_create :assign_filter_column



  private

  def assign_filter_column
    cols = self.category.category_options.pluck(:filter_column_name)
    available_cols = PRODUCT_FILTER_COLUMN_NAMES - cols
    if available_cols.present?
      self.filter_column_name = available_cols.first
    end
  end

end
