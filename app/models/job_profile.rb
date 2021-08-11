class JobProfile < ApplicationRecord
  belongs_to :shop
  belongs_to :vehicle_variant, optional: true
  belongs_to :job

  has_many :jobsheets, through: :job_trackers
  has_many :job_trackers
end
