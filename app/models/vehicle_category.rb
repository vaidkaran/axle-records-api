class VehicleCategory < ApplicationRecord
  has_many :vehicles
  has_many :vehicle_models
end
