class CreateSparePartProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :spare_part_profiles do |t|
      t.decimal :price, precision: 7, scale: 2 # upto 2 decimal digits
      t.belongs_to :shop, index: true, foreign_key: true
      t.belongs_to :vehicle_variant, index: true, foreign_key: true
      t.belongs_to :spare_part, index: true, foreign_key: true

      t.timestamps
    end
  end
end
