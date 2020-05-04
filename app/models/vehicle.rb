class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_variant

  has_one :registration_detail
  has_many :jobsheets
end
