class VehicleVariant < ApplicationRecord
  has_many :vehicles
  belongs_to :vehicle_model
end
