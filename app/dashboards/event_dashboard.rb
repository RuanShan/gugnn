require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    jointables: Field::HasMany,
    users: Field::HasMany,
    pictures: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    body: Field::Text,
    category: Field::String,
    price: Field::String.with_options(searchable: false),
    address: Field::String,
    date: Field::String,
    zipcode: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    user_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :jointables,
    :users,
    :pictures,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :jointables,
    :users,
    :pictures,
    :id,
    :title,
    :body,
    :category,
    :price,
    :address,
    :date,
    :zipcode,
    :created_at,
    :updated_at,
    :user_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :jointables,
    :users,
    :pictures,
    :title,
    :body,
    :category,
    :price,
    :address,
    :date,
    :zipcode,
    :user_id,
  ].freeze

  # Overwrite this method to customize how events are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(event)
  #   "Event ##{event.id}"
  # end
end
