class CreateCollection < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.references :user, foreign_key: {to_table: :users}
      t.references :product, foreign_key: {to_table: :products}
      t.timestamps
    end
    add_index(:collections, [:user_id, :product_id] )

  end
end
