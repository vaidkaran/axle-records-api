class FixVehicleCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :vehicle_category_id
    add_reference :vehicle_models, :vehicle_category, index: true
    add_foreign_key :vehicle_models, :vehicle_categories
  end
end
