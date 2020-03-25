class VendorShopRole < ApplicationRecord
  belongs_to :vendor_role
  belongs_to :shop
  belongs_to :user

  validates :vendor_role, presence: true
  validates :shop, presence: true
  validates :user, presence: true
end
