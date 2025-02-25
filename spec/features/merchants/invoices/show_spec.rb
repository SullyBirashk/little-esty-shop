require 'rails_helper'

RSpec.describe "Merchant Invoices Show Page" do
  before (:each) do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder_Miflin")

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 50, quantity_threshold: 4)
    @discount_2 = @merchant_2.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    @discount_3 = @merchant_2.bulk_discounts.create!(percentage: 10, quantity_threshold: 3)

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    @customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    @customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    @customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    @customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")
    @invoice_5 = @customer_2.invoices.create!(status: "cancelled")
    @invoice_6 = @customer_3.invoices.create!(status: "in progress")
    @invoice_7  = @customer_3.invoices.create!(status: "completed")
    @invoice_8 = @customer_3.invoices.create!(status: "cancelled")
    @invoice_9 = @customer_4.invoices.create!(status: "in progress")
    @invoice_10 = @customer_4.invoices.create!(status: "completed")
    @invoice_11 = @customer_5.invoices.create!(status: "cancelled")
    @invoice_12 = @customer_6.invoices.create!(status: "in progress")
    @invoice_15 = @customer_6.invoices.create!(status: "in progress")

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending")
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped")
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 5, unit_price: 13, status: "packaged")
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_2.id, quantity: 6, unit_price: 29, status: "pending")
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_3.id, quantity: 1, unit_price: 84, status: "shipped")
    @invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_4.id, quantity: 2, unit_price: 25, status: "packaged")
    @invoice_item_9 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_1.id, quantity: 3, unit_price: 13, status: "pending")
    @invoice_item_10 = InvoiceItem.create!(invoice_id: @invoice_10.id, item_id: @item_2.id, quantity: 4, unit_price: 29, status: "shipped")
    @invoice_item_11 = InvoiceItem.create!(invoice_id: @invoice_11.id, item_id: @item_3.id, quantity: 5, unit_price: 84, status: "packaged")
    @invoice_item_12 = InvoiceItem.create!(invoice_id: @invoice_12.id, item_id: @item_4.id, quantity: 6, unit_price: 25, status: "pending")

    @merchant_3 = Merchant.create!(name: "Dunder_Miflin_2.0")

    @discount_4 = @merchant_3.bulk_discounts.create!(percentage: 50, quantity_threshold: 4)

    @item_20 = @merchant_3.items.create!(name: "mouse", description: "click", unit_price: 20)
    @item_21 = @merchant_3.items.create!(name: "keyboard", description: "clack", unit_price: 40)
    @item_22 = @merchant_3.items.create!(name: "test", description: "tea est", unit_price: 30)

    @invoice_20 = @customer_1.invoices.create!(status: "completed")

    @invoice_item_20 = InvoiceItem.create!(invoice_id: @invoice_20.id, item_id: @item_20.id, quantity: 2, unit_price: 30, status: "shipped")
    @invoice_item_22 = InvoiceItem.create!(invoice_id: @invoice_20.id, item_id: @item_21.id, quantity: 5, unit_price: 10, status: "shipped")
    @invoice_item_23 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_22.id, quantity: 5, unit_price: 10, status: "shipped")

    @merchant_4 = Merchant.create!(name: "Dunder_Miflin_2.0")

    @discount_5 = @merchant_4.bulk_discounts.create!(percentage: 50, quantity_threshold: 10)
    @discount_6 = @merchant_4.bulk_discounts.create!(percentage: 20, quantity_threshold: 12)

    @item_23 = @merchant_4.items.create!(name: "mouse", description: "click", unit_price: 20)
    @item_24 = @merchant_4.items.create!(name: "keyboard", description: "clack", unit_price: 40)
    @item_25 = @merchant_4.items.create!(name: "test", description: "tea est", unit_price: 30)

    @invoice_22 = @customer_1.invoices.create!(status: "completed")

    @invoice_item_24 = InvoiceItem.create!(invoice_id: @invoice_22.id, item_id: @item_23.id, quantity: 5, unit_price: 10, status: "shipped")
    @invoice_item_25 = InvoiceItem.create!(invoice_id: @invoice_22.id, item_id: @item_24.id, quantity: 12, unit_price: 10, status: "shipped")
    @invoice_item_26 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_25.id, quantity: 7, unit_price: 5, status: "shipped")
  end

  it "displays the invoice id, status, when it was created and customer name" do
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
  end

  it "displays all the invoice items names, qty, price, and shipping status" do
    @invoice_item_13 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 29, status: "shipped")

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Item name: #{@item_1.name}")
    expect(page).to have_content("Item name: #{@item_2.name}")
    expect(page).to_not have_content("Item name: #{@item_3.name}")

    expect(page).to have_content("Qty: #{@invoice_item_1.quantity}")
    expect(page).to have_content("Qty: #{@invoice_item_13.quantity}")
    expect(page).to_not have_content("Qty: #{@invoice_item_3.quantity}")

    expect(page).to have_content("Unit price: #{@item_1.unit_price}")
    expect(page).to have_content("Unit price: #{@item_2.unit_price}")

    expect(page).to have_content("Status: #{@invoice_item_1.status}")
    expect(page).to have_content("Status: #{@invoice_item_13.status}")
  end

  it "displays total revenue" do
    visit "/merchants/#{@merchant_3.id}/invoices/#{@invoice_20.id}"

    expect(page).to have_content("Total Revenue: 110")
  end

  it "can change an item's status" do
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Status: shipped")
    expect(page).to_not have_content("Status: packaged")

    choose('packaged')
    click_on('Update Item Status')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

    expect(page).to_not have_content("Status: shipped")
    expect(page).to have_content("Status: packaged")
  end

  it "shows revenue with and without discount applied" do

    visit "/merchants/#{@merchant_3.id}/invoices/#{@invoice_20.id}"

    within ".undiscounted_revenue" do
      expect(page).to have_content("Total Revenue: 110")
    end

    within ".discounted_revenue" do
      expect(page).to have_content("Total Discounted Revenue: 85.0")
    end
  end

  it "chooses the Best Bulk discount" do
    visit "/merchants/#{@merchant_4.id}/invoices/#{@invoice_22.id}"

    within ".discounted_revenue" do
      expect(page).to have_content("Total Discounted Revenue: 110.0")
    end
  end

  it "next to each invoice item is a link to applied bulk_discount" do
    visit "/merchants/#{@merchant_4.id}/invoices/#{@invoice_22.id}"

    expect(page).to have_link("View Keyboard Discount")
    expect(page).to_not have_link("View Mouse Discount")

    click_link("View Keyboard Discount")

    expect(current_path).to eq("/merchants/#{@merchant_4.id}/bulk_discounts/#{@discount_5.id}")
  end
end
