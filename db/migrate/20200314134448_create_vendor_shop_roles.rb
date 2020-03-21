class CreateVendorShopRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :vendor_shop_roles do |t|
      t.belongs_to :vendor_role, index: true, foreign_key: true
      t.belongs_to :shop, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
