class AddApiSecretKeyToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :api_secret_key, :string
  end
end
