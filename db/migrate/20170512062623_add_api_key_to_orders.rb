class AddApiKeyToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :api_key, :string
  end
end
