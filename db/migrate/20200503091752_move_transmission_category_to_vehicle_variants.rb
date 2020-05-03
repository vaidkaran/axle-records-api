class MoveTransmissionCategoryToVehicleVariants < ActiveRecord::Migration[5.2]
  def change
  	remove_column :vehicles, :transmission_category_id
  	add_reference :vehicle_variants, :transmission_category, index: true
    add_foreign_key :vehicle_variants, :transmission_categories
  end
end
