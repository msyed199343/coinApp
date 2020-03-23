class AddColumnToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :type, :string, null: false
  end
end
