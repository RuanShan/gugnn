class AddLatlngAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :latlng_address, :string
    add_column :users, :latlng_address, :string
  end
end
