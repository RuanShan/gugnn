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
    events: Field::HasMany,
    rents: Field::HasMany,
    sales: Field::HasMany,
    jointables: Field::HasMany,
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
    avatar_file_name: Field::String,
    avatar_content_type: Field::String,
    avatar_file_size: Field::Number,
    avatar_updated_at: Field::DateTime,
    rating: Field::Number.with_options(decimals: 2),
    city: Field::String,
    balance: Field::Number,
    role: Field::String.with_options(searchable: false),
    is_admin: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :conversations,
    :events,
    :rents,
    :sales,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :conversations,
    :events,
    :rents,
    :sales,
    :jointables,
    :id,
    :cellphone,
    :email,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :nickname,
    :realname,
    :avatar_file_name,
    :avatar_content_type,
    :avatar_file_size,
    :avatar_updated_at,
    :rating,
    :city,
    :balance,
    :role,
    :is_admin,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :conversations,
    :events,
    :rents,
    :sales,
    :jointables,
    :cellphone,
    :email,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :nickname,
    :realname,
    :avatar_file_name,
    :avatar_content_type,
    :avatar_file_size,
    :avatar_updated_at,
    :rating,
    :city,
    :balance,
    :role,
    :is_admin,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
