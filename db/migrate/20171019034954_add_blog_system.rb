class AddBlogSystem < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_categories do |t|
      t.integer :ctype, default: 0
      t.integer :position
      t.string :title
      t.string :permalink
      t.text :description
      t.timestamps null: false
    end

    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.string :permalink
      t.attachment :image
      t.boolean :published, default: false
      t.datetime :published_at
      t.timestamps null: false
    end
    add_reference :blog_posts, :user, index: true
    add_reference :blog_posts, :blog_category, index: true


    #create_table :blog_images do |t|
    #  t.integer :post_id
    #  t.string :image
    #  t.timestamps null: false
    #end
    #add_index :blog_images, :post_id

    #create_table :blog_tags do |t|
    #  t.string :name
    #  t.string :permalink
    #  t.timestamps null: false
    #end

    #create_table :blog_taggings do |t|
    #  t.belongs_to :tag, index: true
    #  t.belongs_to :post, index: true
    #  t.timestamps
    #end


    #create_table :blog_comments do |t|
    #  t.belongs_to :post, index: true
    #  t.belongs_to :user, index: true
    #  t.text :content
    #  t.string :author_name
    #  t.string :author_email
    #  t.timestamps null: false
    #end


  end
end
