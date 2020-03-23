class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :name, null: false
      t.integer :value, null:false
      
      t.timestamps 
    end
  end
end
