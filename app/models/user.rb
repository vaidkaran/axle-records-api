class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  belongs_to :site_role, optional: true
  has_many :vendor_shop_roles
  has_many :shops
  has_many :vehicles

  def is_admin
    return self.site_role == SiteRole.find_by(name: :admin)
  end

  def is_customer
    return self.site_role == SiteRole.find_by(name: :customer)
  end

  def is_vendor
    return self.site_role == SiteRole.find_by(name: :vendor)
  end
end
