class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :site_roles, optional: true
  has_many :vendor_shop_roles
  has_many :vehicles
end
