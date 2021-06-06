class Jobsheet < ApplicationRecord
  has_many :job_profiles, through: :job_trackers
  has_many :job_trackers, dependent: :destroy
  has_many :jobsheet_state_trackers, dependent: :destroy
  has_one :bill

  belongs_to :vehicle
  belongs_to :shop
end