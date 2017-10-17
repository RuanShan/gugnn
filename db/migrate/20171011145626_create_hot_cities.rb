class CreateHotCities < ActiveRecord::Migration[5.0]
  def change
    create_table :hot_cities do |t|
      t.string :name
      t.string :pinyin
      t.string :acronyms
      t.string :province
      t.string :ppinyin
      t.integer :status
      t.integer :position
      t.timestamps
    end
  end
end
