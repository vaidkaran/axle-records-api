class DropVendorRoleTypeTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :vendor_role_types
  end
end
