class AddParentCategoryIntoProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :parent_category, foreign_key: {to_table: :categories}

    add_index :products, [:parent_category_id, :category_id, :published_at], name: 'idx_products_pcategory_category_publish'
  end
end
