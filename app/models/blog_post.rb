  class BlogPost < ApplicationRecord

    belongs_to :blog_category
    belongs_to :user, class_name: "User"
    #has_many :taggings, class_name: "BlogTagging"
    #has_many :tags, through: :taggings, class_name: "BlogTag"
    #has_many :comments, class_name: "BlogComment"

    validates_presence_of :title, :content

    has_attached_file :image, styles: { small: '180x120>', large: '670x370>'}, default_url: "default.png"

    scope :published, -> { where "published = ? AND published_at <= ?", true, Time.now.to_s }
    scope :draft,    -> { where published: false }


    # The date parsed as 04 November 2013
    #
    # @return [String]
    def date_parsed
      published && published_at.present? ? published_at.strftime("%d %B %Y") : ""
    end

    # The Markdown content rendered to HTML
    #
    # @return [String]
    def content_rendered
      #markdown(content).html_safe
    end

  end
