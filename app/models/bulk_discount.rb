class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :merchant

  validates_presence_of(:percentage)
  validates_presence_of(:quantity_threshold)

end
