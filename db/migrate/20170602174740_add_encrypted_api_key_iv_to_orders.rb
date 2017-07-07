class AddEncryptedApiKeyIvToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :encrypted_api_key_iv, :string
  end
end
