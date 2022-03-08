require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe "class methods" do
    it "can return all invoices that are incomplete aka 'in progress'" do
      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

      invoice_1 = customer_1.invoices.create!(status: "in progress")
      invoice_2 = customer_1.invoices.create!(status: "in progress")
      invoice_3 = customer_1.invoices.create!(status: "completed")
      invoice_4 = customer_1.invoices.create!(status: "completed")
      invoice_5 = customer_1.invoices.create!(status: "completed")

      Invoice.not_completed
    end
  end

  describe 'instance_methods' do
    before (:each) do
      @merchant_1 = Merchant.create!(name: "Staples")

      @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
      @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
      @item_3 = @merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
      @item_4 = @merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

      @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

      @invoice_1 = @customer_1.invoices.create!(status: "completed")

      @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    end

    it ".total_invoice_revenue" do
      @invoice_item_13 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 13, status: "shipped")
      @invoice_item_14 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "shipped")

      expect(@invoice_1.total_revenue_by_merchant(@merchant_1.id)).to eq(84)
      expect(@invoice_1.total_invoice_revenue).to eq(84)
    end

    it "Calculates Total Revenue after Discount" do
      merchant_4 = Merchant.create!(name: "Dunder_Miflin_2.0")

      discount_5 = merchant_4.bulk_discounts.create!(percentage: 50, quantity_threshold: 10)
      discount_6 = merchant_4.bulk_discounts.create!(percentage: 20, quantity_threshold: 12)

      item_23 = merchant_4.items.create!(name: "mouse", description: "click", unit_price: 20)
      item_24 = merchant_4.items.create!(name: "keyboard", description: "clack", unit_price: 40)
      item_25 = merchant_4.items.create!(name: "test", description: "tea est", unit_price: 30)

      invoice_22 = @customer_1.invoices.create!(status: "completed")

      invoice_item_24 = InvoiceItem.create!(invoice_id: invoice_22.id, item_id: item_23.id, quantity: 5, unit_price: 10, status: "shipped")
      invoice_item_25 = InvoiceItem.create!(invoice_id: invoice_22.id, item_id: item_24.id, quantity: 12, unit_price: 10, status: "shipped")
      invoice_item_26 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: item_25.id, quantity: 7, unit_price: 5, status: "shipped")


      expect(invoice_22.revenue_after_discount).to eq(110.0)
    end
  end
end
