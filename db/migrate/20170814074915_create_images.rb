class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.belongs_to :imageable, :polymorphic => true

      t.string :caption
      t.integer :rent_id
      t.attachment :photo

      t.timestamps
    end
  end
end
