class BlogCategory < ApplicationRecord
  acts_as_list scope: [:ctype]

  has_many :blog_posts, dependent: :destroy  
  # about 关于我们，我是租户，我是租赁商
  enum ctype: { about: 0, help: 1, news: 2 },  _prefix: true

  before_validation { self.permalink = self.title.parameterize if self.title && self.permalink.blank? }

  validates_uniqueness_of :title, :permalink
  validates_presence_of :title, :permalink

end
