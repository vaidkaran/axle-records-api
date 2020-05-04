class Shop < ApplicationRecord
  has_many :vendor_shop_roles, dependent: :destroy
  has_many :job_profiles, dependent: :destroy
  has_many :spare_part_profiles, dependent: :destroy
  has_many :jobsheets
end
