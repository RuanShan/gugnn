class Image < ApplicationRecord
  belongs_to :rent
  belongs_to :imageable, class_name: 'Product'
  has_attached_file :photo, :styles => { :small => "150x150>", :large => "585x400>" },
    default_url: "default.png"

  validates_attachment :photo, presence: true,
    content_type: { content_type: /\Aimage\/.*\z/ },
    size: { in: 0..5.megabytes }
end
