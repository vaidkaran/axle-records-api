class AddForeignKeysToVehicleTables < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :vehicles, :users
    add_foreign_key :vehicles, :vehicle_categories
    add_foreign_key :vehicles, :fuel_categories
    add_foreign_key :vehicles, :transmission_categories
    add_foreign_key :vehicles, :vehicle_brands
    add_foreign_key :vehicles, :vehicle_models
    add_foreign_key :vehicles, :vehicle_variants

    add_foreign_key :registration_details, :vehicles

    add_foreign_key :vehicle_models, :vehicle_brands

    add_foreign_key :vehicle_variants, :vehicle_models
    add_foreign_key :vehicle_variants, :vehicle_brands
  end
end
