class ChangeCoins < ActiveRecord::Migration[5.2]
  def change
    change_column :coins, :created_at, :datetime, null: true
    change_column :coins, :updated_at, :datetime, null: true
  end
end
