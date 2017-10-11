class AddProductAd < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :ad, :string
  end
end
