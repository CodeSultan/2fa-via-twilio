class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :user_id
      t.string :exchange_type
      t.string :frequency_type
      t.boolean :invest_type

      t.timestamps
    end
  end
end
