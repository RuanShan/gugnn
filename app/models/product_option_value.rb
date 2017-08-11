class ProductOptionValue < ApplicationRecord
  belongs_to :product, polymorphic: true 
end
