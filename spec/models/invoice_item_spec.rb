require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe "class methods" do
    before :each do
      InvoiceItem.destroy_all
      @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

      @invoice_1 = @customer_1.invoices.create!(status: "in progress")

      @merchant_1 = Merchant.create!(name: "Staples")

      @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 10)

      @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: "shipped")

    end
    it "can show invoice_items revenue" do
      expect(InvoiceItem.revenue).to eq(10)
    end
  end
end
