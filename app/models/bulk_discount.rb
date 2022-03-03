class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount_rate, presence: true
  validates :threshold, presence: true
  validates :merchant_id, presence: true
end
