require "administrate/base_dashboard"

class PcDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    category: Field::BelongsTo,
    owner: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    type: Field::String,
    title: Field::String,
    desc: Field::String,
    slugged: Field::String,
    owner_id: Field::Number,
    price: Field::Number,
    combofilters: Field::String,
    filt1: Field::String.with_options(searchable: false),
    filt2: Field::String.with_options(searchable: false),
    filt3: Field::Number,
    filt4: Field::Number,
    filt5: Field::Number,
    filt6: Field::Number,
    filt7: Field::Number,
    filt8: Field::Number,
    filt9: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :category,
    :owner,
    :id,
    :type,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :category,
    :owner,
    :id,
    :type,
    :title,
    :desc,
    :slugged,
    :owner_id,
    :price,
    :combofilters,
    :filt1,
    :filt2,
    :filt3,
    :filt4,
    :filt5,
    :filt6,
    :filt7,
    :filt8,
    :filt9,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :category,
    :owner,
    :type,
    :title,
    :desc,
    :slugged,
    :owner_id,
    :price,
    :combofilters,
    :filt1,
    :filt2,
    :filt3,
    :filt4,
    :filt5,
    :filt6,
    :filt7,
    :filt8,
    :filt9,
  ].freeze

  # Overwrite this method to customize how pcs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(pc)
  #   "Lease::Pc ##{pc.id}"
  # end
end
