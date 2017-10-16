class AddCityToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :city, foreign_key: {to_table: :hot_cities}
  end
end
