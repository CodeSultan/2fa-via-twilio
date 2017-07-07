class AddEncryptedApiSecretKeyToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :encrypted_api_secret_key, :string
  end
end
