class MoveFuelCategoryToVehicleVariants < ActiveRecord::Migration[5.2]
  def change
  	remove_column :vehicles, :fuel_category_id
  	add_reference :vehicle_variants, :fuel_category, index: true
    add_foreign_key :vehicle_variants, :fuel_categories
  end
end
