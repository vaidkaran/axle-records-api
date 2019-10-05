class CreateVendorRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :vendor_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
