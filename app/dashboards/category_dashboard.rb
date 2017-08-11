require "administrate/base_dashboard"

class CategoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    parent: Field::BelongsTo.with_options(class_name: "Category"),
    children: Field::HasMany.with_options(class_name: "Category"),
    id: Field::Number,
    title: Field::String,
    parent_id: Field::Number,
    lft: Field::Number,
    rgt: Field::Number,
    depth: Field::Number,
    children_count: Field::Number,
    desc: Field::String,
    slugged: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :parent,
    :children,
    :id,
    :title,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :parent,
    :children,
    :id,
    :title,
    :parent_id,
    :lft,
    :rgt,
    :depth,
    :children_count,
    :desc,
    :slugged,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :parent,
    :children,
    :title,
    :parent_id,
    :lft,
    :rgt,
    :depth,
    :children_count,
    :desc,
    :slugged,
  ].freeze

  # Overwrite this method to customize how categories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(category)
  #   "Category ##{category.id}"
  # end
end
