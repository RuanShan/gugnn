class AddCollectionCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :collection_count, :integer, default: 0, null: false
  end
end
