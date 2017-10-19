require "administrate/base_dashboard"

class BlogPostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    blog_category: Field::BelongsTo.with_options(class_name: "BlogCategory"),
    user: Field::BelongsTo,
    #taggings: Field::HasMany.with_options(class_name: "BlogTagging"),
    #tags: Field::HasMany.with_options(class_name: "BlogTag"),
    #comments: Field::HasMany.with_options(class_name: "BlogComment"),
    id: Field::Number,
    title: Field::String,
    content: Field::Ckeditor,
    permalink: Field::String,
    image: Field::Paperclip,
    published: Field::Boolean,
    published_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    blog_category_id: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :blog_category,
    :user,
    :title,
    :permalink,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :blog_category,
    :user,
    :id,
    :title,
    :content,
    :permalink,
    :image,
    :published,
    :published_at,
    :created_at,
    :updated_at,
    :blog_category_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :blog_category,
    :user,
    #:taggings,
    #:tags,
    #:comments,
    :title,
    :content,
    :permalink,
    :image,
    :published,
    :published_at,
  ].freeze

  # Overwrite this method to customize how blog posts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(blog_post)
  #   "BlogPost ##{blog_post.id}"
  # end
end
