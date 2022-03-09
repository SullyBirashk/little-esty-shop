class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}

  validates_presence_of :status

  def total_invoice_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def items_by_merchant(merchant_id)
      invoice_items.joins(:item)
                    .where('merchant_id = ?', merchant_id)
  end

  def total_revenue_by_merchant(merchant_id)
    items_by_merchant(merchant_id)
    .pluck(Arel.sql("invoice_items.unit_price * invoice_items.quantity"))
    .sum
  end

  def self.not_completed
    where(:invoices => {status: 1}).order(created_at: :asc)
  end

  def bulk_discount
   invoice_items.joins(:bulk_discounts)
    .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage)/100) as total_discount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group("invoice_items.id")
    .inject(0) { |sum, ii| sum + ii.total_discount }
  end

  def revenue_after_discount
    invoice_items.revenue.to_f - bulk_discount
  end
end
