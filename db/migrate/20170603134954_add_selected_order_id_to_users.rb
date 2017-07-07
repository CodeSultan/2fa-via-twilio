class AddSelectedOrderIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :selected_order_id, :int
  end
end
