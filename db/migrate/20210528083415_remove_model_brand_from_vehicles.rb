class RemoveModelBrandFromVehicles < ActiveRecord::Migration[5.2]
  def change
  	remove_column :vehicles, :vehicle_model_id
  	remove_column :vehicles, :vehicle_brand_id
  end
end
