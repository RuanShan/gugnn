class CreateCategoryOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :category_options do |t|
      t.belongs_to :category
      t.string :name # 内部名称
      t.string :title       # 网页上显示名词

      t.timestamps
    end
  end
end
