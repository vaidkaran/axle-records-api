class Job < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  has_many :job_profiles
end
