class SparePartProfile < ApplicationRecord
  belongs_to :shop
  belongs_to :vehicle_variant
  belongs_to :spare_part
end
