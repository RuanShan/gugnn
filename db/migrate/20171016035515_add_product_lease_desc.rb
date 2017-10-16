class AddProductLeaseDesc < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :lease_desc, :text
  end
end
