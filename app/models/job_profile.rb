class JobProfile < ApplicationRecord
  belongs_to :shop
  belongs_to :vehicle_variant
  belongs_to :job
end
