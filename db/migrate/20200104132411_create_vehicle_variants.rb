class CreateVehicleVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_variants do |t|
      t.string :name
      t.belongs_to :vehicle_model, index: true
      t.belongs_to :vehicle_brand, index: true

      t.timestamps
    end
  end
end
