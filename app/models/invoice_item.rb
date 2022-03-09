class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :item

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  def self.revenue
      sum('quantity * unit_price')
  end

  def find_discount
    bulk_discounts.joins(:invoice_items)
    .where("bulk_discounts.quantity_threshold <= ?", quantity)
    .order(percentage: :desc)
    .first
  end
end
