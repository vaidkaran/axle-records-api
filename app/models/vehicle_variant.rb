class VehicleVariant < ApplicationRecord
  has_many :vehicles
  has_many :job_profiles
  has_many :spare_part_profiles
  belongs_to :vehicle_model

  # optional for now; Should ideally not be optional
  belongs_to :fuel_category, optional: true
  belongs_to :transmission_category, optional: true
end
