class RemoveBrandFromVariants < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicle_variants, :vehicle_brand_id
  end
end
