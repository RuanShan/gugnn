class AddPageClicks < ActiveRecord::Migration[5.0]
  def change
    create_table :page_clicks do |t|
      t.integer :category_id, null: false, default: 0
      t.integer :pv, null: false, default: 0
      t.integer :uv, null: false, default: 0
      t.references :pageable, polymorphic: true, index: true
      t.references :clickable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
