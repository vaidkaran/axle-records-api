class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_variant

  has_one :registration_detail
  has_many :jobsheets

  validates :user, presence: true
  validates :vehicle_variant, presence: true
end
