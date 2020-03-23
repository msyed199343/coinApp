class UsersAddNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :password_digest, null: false
    change_column_null :users, :email, null: false
  end
end
