require "administrate/base_dashboard"

class RatingCachDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    cacheable: Field::Polymorphic,
    id: Field::Number,
    avg: Field::Number.with_options(decimals: 2),
    qty: Field::Number,
    dimension: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :cacheable,
    :id,
    :avg,
    :qty,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :cacheable,
    :id,
    :avg,
    :qty,
    :dimension,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :cacheable,
    :avg,
    :qty,
    :dimension,
  ].freeze

  # Overwrite this method to customize how rating caches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(rating_cach)
  #   "RatingCach ##{rating_cach.id}"
  # end
end
