class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :desc
      t.string :slugged
      t.integer :owner_id
      t.integer :price

      t.timestamps
    end
  end
end
