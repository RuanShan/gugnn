#产品抽象类
class Product < ApplicationRecord
  #self.abstract_class = true

  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'


  # 添加产品，
  # 修改产品，修改过滤字段
  # 改变字段顺序

  # 定义 过滤条件
  # 如： { name: 'brand', title: '品牌', values: [[1,'lenovo','联想'],[2,'asus','华硕']]}
  # enum :tilt1, { apple: 1,lenovo: 2}
  class << self
    def setup_filters( filters )
      filters.each_with_index{|filter, i|
        field_name = "filt#{i+1}".to_sym
        prefix = filter[:name]
        vals = filter[:values]
        vals_for_enum = vals.map{|v| v[0,2]}
        hash_for_enum = Hash[vals_for_enum]
        #Rails.logger.debug " field_name=#{field_name}, hash_for_enum=#{hash_for_enum}"
        enum(field_name => hash_for_enum, _prefix: prefix )
        #generate method brand_lenovo
      }
    end
  end



end
