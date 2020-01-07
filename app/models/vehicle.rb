class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_category
  belongs_to :fuel_category
  belongs_to :transmission_category
  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_variant

  has_one :registration_detail
end
