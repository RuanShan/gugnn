class CreateCategoryOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :category_options do |t|
      t.belongs_to :category
      t.integer :position

      t.string :name # 内部名称
      t.string :title       # 网页上显示名词
      t.string :values

      # 对应产品表的哪一列，通常创建时自动分配可用列，删除时自动释放。
      t.string :filter_column_name
      t.timestamps
    end
  end
end
