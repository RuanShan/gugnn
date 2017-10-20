class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: {to_table: :users}
      t.references :recipient, foreign_key: {to_table: :users}
      t.integer :status
      t.timestamps
    end

    add_index(:messages, [:user_id, :recipient_id] )

  end
end
