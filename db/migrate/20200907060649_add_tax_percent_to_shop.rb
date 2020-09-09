class AddTaxPercentToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :tax_percent, :decimal
  end
end
