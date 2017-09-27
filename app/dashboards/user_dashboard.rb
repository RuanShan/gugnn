require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    conversations: Field::HasMany,
    products: Field::HasMany,
    category: Field::BelongsTo,
    id: Field::Number,
    cellphone: Field::String,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    nickname: Field::String,
    realname: Field::String,
    avatar: Field::Paperclip,
    rating: Field::Number.with_options(decimals: 2),
    city: Field::String,
    balance: Field::Number,
    role: Field::String.with_options(searchable: false),
    is_admin: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    auth_type: Field::Number,
    authenticated: Field::Boolean,
    id_auth_status: Field::Number,
    id_number: Field::String,
    id_photo: Field::Paperclip,
    id_photo_updated_at: Field::DateTime,
    licence_auth_status: Field::Number,
    licence_number: Field::String,
    licence_photo: Field::Paperclip,
    licence_photo_updated_at: Field::DateTime,
    shop_name: Field::String,
    licence_photo_file_name: Field::String,
    licence_photo_content_type: Field::String,
    licence_photo_file_size: Field::Number,
    licence_photo_updated_at: Field::DateTime,
    shop_address: Field::String,
    lat: Field::String.with_options(searchable: false),
    lng: Field::String.with_options(searchable: false),
    contact_person: Field::String,
    contact_phone: Field::String,
    contact_other: Field::String,
    latlng_address: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :nickname,
    :cellphone,
    :role,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [

    :id,
    :cellphone,
    :email,
    :nickname,
    :realname,
    :role,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :nickname,
    :cellphone,
    :realname,
    :email,
    :avatar,
    :id_auth_status,
    :id_photo,
    :licence_auth_status,
    :licence_photo,
    :role,
  ].freeze
  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
