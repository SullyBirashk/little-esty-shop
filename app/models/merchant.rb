class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def ship_ready_items
    invoice_items.where.not(status: "shipped")
  end

  def customers_list
    customers.distinct
  end

  def top_five_customers
    customers.joins(invoices: :transactions)
             .where(transactions:{result: 1})
             .select("customers.*, COUNT(transactions.*) AS trans_count")
             .group("customers.id")
             .order(trans_count: :desc)
             .limit(5)

   end

   def top_five_items
     items.joins(:invoice_items, invoices: [:transactions])
         .where(transactions:{result: 1})
         .select("items.*, SUM( invoice_items.unit_price * invoice_items.quantity)  AS totalrevenue")
         .group("items.id")
         .order(totalrevenue: :desc)
         .limit(5)
   end
end
