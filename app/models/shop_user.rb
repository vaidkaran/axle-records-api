class ShopUser < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :vendor_role
end
