require "administrate/base_dashboard"

class AverageCachDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rater: Field::BelongsTo.with_options(class_name: "User"),
    rateable: Field::Polymorphic,
    id: Field::Number,
    rater_id: Field::Number,
    avg: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :rater,
    :rateable,
    :id,
    :rater_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :rater,
    :rateable,
    :id,
    :rater_id,
    :avg,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :rater,
    :rateable,
    :rater_id,
    :avg,
  ].freeze

  # Overwrite this method to customize how average caches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(average_cach)
  #   "AverageCach ##{average_cach.id}"
  # end
end
