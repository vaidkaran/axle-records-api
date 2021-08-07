class ChangePinToString < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :pin, :string
  end
end
