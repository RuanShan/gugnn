require "administrate/base_dashboard"

class RentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    images: Field::HasMany,
    user: Field::BelongsTo,
    pictures: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    body: Field::Text,
    category: Field::String,
    price: Field::String.with_options(searchable: false),
    address: Field::String,
    sqfootage: Field::Number,
    bed: Field::Number,
    bath: Field::Number,
    zipcode: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :images,
    :user,
    :pictures,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :images,
    :user,
    :pictures,
    :id,
    :title,
    :body,
    :category,
    :price,
    :address,
    :sqfootage,
    :bed,
    :bath,
    :zipcode,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :images,
    :user,
    :pictures,
    :title,
    :body,
    :category,
    :price,
    :address,
    :sqfootage,
    :bed,
    :bath,
    :zipcode,
  ].freeze

  # Overwrite this method to customize how rents are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(rent)
  #   "Rent ##{rent.id}"
  # end
end