class Bill < ApplicationRecord
  belongs_to :jobsheet

  validates :item_total, presence: true
  validates :grand_total, presence: true
end
