class ChangeDefualtCount < ActiveRecord::Migration[5.2]
  def change
    change_column_default(
    :coins,
    :count,
    0
  )
  end
end
