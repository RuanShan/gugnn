class CategoryPost < ActiveRecord::Base
  validates_uniqueness_of :category_id, :scope => [:post_id]
end
