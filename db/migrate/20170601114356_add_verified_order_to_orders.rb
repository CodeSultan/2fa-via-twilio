class AddVerifiedOrderToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :verified_order, :boolean
  end
end
