#产品抽象类
class Product < ApplicationRecord
  #self.abstract_class = true
  TENANCY_ENUM = [3600, 3600*24, 3600*24*30, 3600*24*30*365]

  belongs_to :category
  # category:所属分类，parent_category: 所属父分类
  # 查询时使用，如：列出办公用品的热门出租产品。或最新出租商品
  belongs_to :parent_category, class_name: 'Category'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :images, as: :imageable, :dependent => :destroy
  has_one :master_image, class_name: 'Image', foreign_key: 'imageable_id'
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }

  #
  before_create :set_defaults

  attribute :latlng, :point
  # parent_category需要
  validates :category, presence: true

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
        vals = filter[:option_values]
        vals_for_enum = vals.map{|v| v[0,2]}
        hash_for_enum = Hash[vals_for_enum]
        #Rails.logger.debug " field_name=#{field_name}, hash_for_enum=#{hash_for_enum}"
        enum(field_name => hash_for_enum, _prefix: prefix )
        #generate method brand_lenovo
      }
    end
  end

  def set_defaults

    self.published_at ||= DateTime.current
    self.parent_category_id ||= category.parent_id
  end

end
