class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_variant

  has_one :registration_detail
  has_many :jobsheets

  validates :user, presence: true
  validates :vehicle_brand, presence: true
  validates :vehicle_model, presence: true
  validates :vehicle_variant, presence: true
end
