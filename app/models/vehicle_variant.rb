class VehicleVariant < ApplicationRecord
  has_many :vehicles
  has_many :job_profiles
  belongs_to :vehicle_model
end
