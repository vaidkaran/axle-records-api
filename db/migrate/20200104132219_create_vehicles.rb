class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :vehicle_category, index: true
      t.belongs_to :fuel_category, index: true
      t.belongs_to :transmission_category, index: true
      t.belongs_to :vehicle_brand, index: true
      t.belongs_to :vehicle_model, index: true
      t.belongs_to :vehicle_variant, index: true

      t.timestamps
    end
  end
end
