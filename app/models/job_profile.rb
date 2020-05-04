class JobProfile < ApplicationRecord
  belongs_to :shop
  belongs_to :vehicle_variant
  belongs_to :job

  has_many :job_profiles, through: :job_trackers
  has_many :job_trackers
end
