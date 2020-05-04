class JobTracker < ApplicationRecord
  belongs_to :jobsheet
  belongs_to :job_profile
end
