class CreateOptionValues < ActiveRecord::Migration[5.0]
  def change
    create_table :option_values do |t|
      t.belongs_to :category_option
      t.integer :position
      t.string :name
      t.string :title
      t.timestamps
    end


  end
end
