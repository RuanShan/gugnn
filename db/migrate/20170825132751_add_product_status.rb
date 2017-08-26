class AddProductStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :visits, :integer, default: 0, null: false
    add_column :products, :status, :integer, default: 0, null: false
    add_column :products, :authenticated_at, :datetime
    add_column :products, :withdraw_at, :datetime
    add_index :products, :visits
    add_index :products, :status
  end
end
