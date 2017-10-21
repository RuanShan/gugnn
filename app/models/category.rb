class Category < ApplicationRecord
  acts_as_nested_set

  has_one :page_click, as: :pageable
  has_many :category_options
  has_many :products
  #当前分类的所有子分类所属的 products
  has_many :subproducts, class_name: 'Product', foreign_key: :parent_category_id

  #显示在首页的前8个
  has_many :highlight_subproducts, ->{ order(published_at: :desc).limit(8) }, class_name: 'Product', foreign_key: :parent_category_id
  #has_many :highlight_products, ->{ order(published_at: :desc).limit(8) }, class_name: 'Product'

  has_attached_file :icon,
    styles: { mini: '32x32>', normal: '128x128>' },
    url: '/uploads/categories/:id/:style/:basename.:extension',
    path: ':rails_root/public/uploads/categories/:id/:style/:basename.:extension',
    default_url: '/assets/default.png'

  validates_attachment :icon,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
