class RemoveShopUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :shop_users
  end
end
