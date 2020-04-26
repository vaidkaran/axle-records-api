class SparePart < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  has_many :spare_part_profiles
end
