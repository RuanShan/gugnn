class PageClick < ApplicationRecord
  belongs_to :clickable, polymorphic: true
  belongs_to :pageable, polymorphic: true

  scope :on_page, ->(page){ where pageable: page }
  scope :on_option_values, ->{ where( clickable_type: 'OptionValue').order( pv: :desc)}
end
