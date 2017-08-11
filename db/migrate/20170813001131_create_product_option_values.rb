class CreateProductOptionValues < ActiveRecord::Migration[5.0]
  def change
    create_table :product_option_values do |t|
      t.string :title
      t.belongs_to :category
      t.belongs_to :product, polymorphic: true, index: true
      t.belongs_to :category_option
      t.belongs_to :option_value
      t.timestamps
    end
  end
end
