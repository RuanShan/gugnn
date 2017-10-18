class HotCity < ApplicationRecord
  before_create :set_pinyin
  acts_as_list scope: [:province]

  enum status: { disabled: 4, popular: 5, normal: 0 }

  private
  def set_pinyin
    self.ppinyin = PinYin.of_string( self.province ).join
  end
end
