require "administrate/base_dashboard"

class BlogCategoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    blog_posts: Field::HasMany,
    id: Field::Number,
    ctype: Field::String.with_options(searchable: false),
    position: Field::Number,
    title: Field::String,
    permalink: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :blog_posts,
    :title,    
    :ctype,
    :position,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :blog_posts,
    :id,
    :ctype,
    :position,
    :title,
    :permalink,
    :description,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :blog_posts,
    :ctype,
    :position,
    :title,
    :permalink,
    :description,
  ].freeze

  # Overwrite this method to customize how blog categories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(blog_category)
  #   "BlogCategory ##{blog_category.id}"
  # end
end
