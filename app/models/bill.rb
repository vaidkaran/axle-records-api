class Bill < ApplicationRecord
  belongs_to :jobsheet

  validates :total_amount, presence: true
end
