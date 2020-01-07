class VehicleModel < ApplicationRecord
  has_many :vehicles
  has_many :vehicle_variants

  belongs_to :vehicle_brand
end
