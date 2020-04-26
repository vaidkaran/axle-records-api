class VehicleVariant < ApplicationRecord
  has_many :vehicles
  has_many :job_profiles
  has_many :spare_part_profiles
  belongs_to :vehicle_model
end
