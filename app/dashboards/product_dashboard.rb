require "administrate/base_dashboard"

class ProductDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    category: Field::BelongsTo,
    parent_category: Field::BelongsTo.with_options(class_name: "Category"),
    owner: Field::BelongsTo.with_options(class_name: "User"),
    images: Field::HasMany,
    id: Field::Number,
    type: Field::String,
    title: Field::String,
    desc: Field::Ckeditor,
    slugged: Field::String,
    owner_id: Field::Number,
    price: Field::Number,
    tenancy: Field::String.with_options(searchable: false),
    min_tenancy: Field::String.with_options(searchable: false),
    max_tenancy: Field::Number,
    deposit: Field::Number,
    combofilters: Field::String,
    filt0: Field::Number,
    filt1: Field::Number,
    filt2: Field::Number,
    filt3: Field::Number,
    filt4: Field::Number,
    filt5: Field::Number,
    filt6: Field::Number,
    filt7: Field::Number,
    filt8: Field::Number,
    filt9: Field::Number,
    published_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    address: Field::String,
    postal_code: Field::String,
    created_ip: Field::String.with_options(searchable: false),
    lat: Field::String.with_options(searchable: false),
    lng: Field::String.with_options(searchable: false),
    latlng: Field::String.with_options(searchable: false),
    parent_category_id: Field::Number,
    visits: Field::Number,
    status: Field::String.with_options(searchable: false),
    authenticated_at: Field::DateTime,
    withdraw_at: Field::DateTime,
    latlng_address: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :category,
    :parent_category,
    :owner,
    :images,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :category,
    :parent_category,
    :owner,
    :images,
    :id,
    :type,
    :title,
    :desc,
    :slugged,
    :owner_id,
    :price,
    :tenancy,
    :min_tenancy,
    :max_tenancy,
    :deposit,
    :combofilters,
    :filt0,
    :filt1,
    :filt2,
    :filt3,
    :filt4,
    :filt5,
    :filt6,
    :filt7,
    :filt8,
    :filt9,
    :published_at,
    :created_at,
    :updated_at,
    :address,
    :postal_code,
    :created_ip,
    :lat,
    :lng,
    :latlng,
    :parent_category_id,
    :visits,
    :status,
    :authenticated_at,
    :withdraw_at,
    :latlng_address,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :category,
    :parent_category,
    :owner,
    :images,
    :type,
    :title,
    :desc,
    :slugged,
    :owner_id,
    :price,
    :tenancy,
    :min_tenancy,
    :max_tenancy,
    :deposit,
    :combofilters,
    :filt0,
    :filt1,
    :filt2,
    :filt3,
    :filt4,
    :filt5,
    :filt6,
    :filt7,
    :filt8,
    :filt9,
    :published_at,
    :address,
    :postal_code,
    :created_ip,
    :lat,
    :lng,
    :latlng,
    :parent_category_id,
    :visits,
    :status,
    :authenticated_at,
    :withdraw_at,
    :latlng_address,
  ].freeze

  # Overwrite this method to customize how products are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(product)
  #   "Product ##{product.id}"
  # end
end
