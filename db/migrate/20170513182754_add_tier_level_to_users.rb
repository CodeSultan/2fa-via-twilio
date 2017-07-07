class AddTierLevelToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tier_level, :integer
  end
end
