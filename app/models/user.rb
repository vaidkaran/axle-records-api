class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  belongs_to :site_role, optional: true
  has_many :vendor_shop_roles
  has_many :vehicles
end
