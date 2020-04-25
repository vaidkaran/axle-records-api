class Shop < ApplicationRecord
  has_many :vendor_shop_roles, dependent: :destroy
  has_many :job_profiles, dependent: :destroy
end
