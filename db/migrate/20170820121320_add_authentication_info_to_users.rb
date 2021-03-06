class AddAuthenticationInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    #0:personal, 1:company
    add_column :users, :auth_type, :integer, default: 0, null: false
    add_column :users, :authenticated, :boolean, default: false, null: false
    add_reference :users, :category, foreign_key: {to_table: :categories}

    #用户个人身份认证
    add_column :users, :id_auth_status, :integer, default: 0, null: false
    add_column :users, :id_number, :string
    add_attachment :users, :id_photo
    #用户企业认证
    add_column :users, :licence_auth_status, :integer, default: 0, null: false
    add_column :users, :licence_number, :string
    add_attachment :users, :licence_photo

    add_column :users, :shop_name, :string
    add_attachment :users, :shop_photo
    add_column :users, :shop_address, :string
    add_column :users, :lat, :decimal
    add_column :users, :lng, :decimal
    add_column :users, :contact_person, :string
    add_column :users, :contact_phone, :string
    add_column :users, :contact_other, :string
  end
end
