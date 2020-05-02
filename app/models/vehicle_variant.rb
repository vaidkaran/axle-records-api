class VehicleVariant < ApplicationRecord
  has_many :vehicles
  has_many :job_profiles
  has_many :spare_part_profiles
  belongs_to :vehicle_model
  belongs_to :fuel_category
  belongs_to :transmission_category
end
