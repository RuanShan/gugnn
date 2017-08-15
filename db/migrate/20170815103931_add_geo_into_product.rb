class AddGeoIntoProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :address, :string
    add_column :products, :postal_code, :string
    add_column :products, :created_ip, :inet
    add_column :products, :lat, :decimal
    add_column :products, :lng, :decimal
    add_column :products, :latlng, :point

  end
end
