class AddEncryptedApiSecretKeyIvToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :encrypted_api_secret_key_iv, :string
  end
end
