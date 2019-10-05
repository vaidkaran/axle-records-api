class CreateShopUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_users do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :vendor_role, foreign_key: true

      t.timestamps
    end
  end
end
