class CreateHotCities < ActiveRecord::Migration[5.0]
  def change
    create_table :hot_cities do |t|
      t.string :name
      t.string :pingyi
      t.string :acronyms
      t.string :province
      t.string :status
      t.string :integer

      t.timestamps
    end
  end
end
