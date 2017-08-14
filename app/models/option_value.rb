class OptionValue < ApplicationRecord
  acts_as_list scope: :category_option_id

  belongs_to :category_option
end
