class ChangeCountDefault < ActiveRecord::Migration[5.2]
  def change

  change_column_default(
    :coins,
    :count,
    1
  )
  end
end
