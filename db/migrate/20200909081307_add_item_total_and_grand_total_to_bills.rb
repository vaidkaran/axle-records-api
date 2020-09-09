class AddItemTotalAndGrandTotalToBills < ActiveRecord::Migration[5.2]
  def change
    rename_column :bills, :total_amount, :grand_total
    add_column :bills, :item_total, :decimal, precision: 7, scale: 2 # upto 2 decimal digits
  end
end
