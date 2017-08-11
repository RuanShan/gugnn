class RatingCach < ActiveRecord::Base
  belongs_to :cacheable, :polymorphic => true
end
