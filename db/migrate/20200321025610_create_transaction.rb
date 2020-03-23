class CreateTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :coin_id, null: false
      #user_id/api_token of api_user which I will add after making user model and migrations

      t.timestamps
    end
  end
end
