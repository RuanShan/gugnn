class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :title

      # awesome_nested_set
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0

      t.string :slogen # 广告词
      t.string :desc
      t.string :slugged
      t.boolean :heading, :null=> false, :default => true

      t.attachment :icon

      t.string :meta_keyword
      t.string :meta_description

      t.timestamps
    end
  end
end
