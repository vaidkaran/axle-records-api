class Shop < ApplicationRecord
  has_many :users, through: :vendor_shop_roles
  has_many :vendor_shop_roles
end
