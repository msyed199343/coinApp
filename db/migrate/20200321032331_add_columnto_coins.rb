class AddColumntoCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :count, :integer, defualt: 0
  end
end
