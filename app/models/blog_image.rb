
  class BlogImage < ApplicationRecord

    belongs_to :post, class_name: "BlogPost"

    validates :file, presence: true

    # has_attached_file :file, :styles => { medium: "500#", thumb: "198x160>", big: "970x"  }, :default_url => "/images/:style/missing.png"

  end
