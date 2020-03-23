class AddNulltotransactions < ActiveRecord::Migration[5.2]
  def change
    change_column_null :transactions, :created_at, null: true
    change_column_null :transactions, :updated_at, null: true
    change_column_null :users, :created_at, null: true
    change_column_null :users, :updated_at, null: true
    change_column_null :transactions, :user_id, null: false
  end
end
