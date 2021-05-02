class User < ApplicationRecord
  has_and_belongs_to_many :site_roles, optional: true
  has_many :vendor_shop_roles
  has_many :vehicles
end
