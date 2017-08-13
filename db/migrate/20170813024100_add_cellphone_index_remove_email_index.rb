class AddCellphoneIndexRemoveEmailIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :email
    add_index :users, :cellphone, unique: true
  end
end
