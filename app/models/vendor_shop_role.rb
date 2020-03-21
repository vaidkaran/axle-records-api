class VendorShopRole < ApplicationRecord
  belongs_to :vendor_role
  belongs_to :shop
  belongs_to :user
end
