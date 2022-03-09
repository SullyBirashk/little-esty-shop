require 'rails_helper'

RSpec.describe "Merchant Bulk Discounts Create Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder_Miflin")

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    @discount_3 = @merchant_2.bulk_discounts.create!(percentage: 10, quantity_threshold: 3)
  end

  it "Create New Merchant Bulk Discount" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"

    within '.create_discount' do
      expect(page).to have_link("Create New Discount")
    end

    click_link("Create New Discount")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/new")

    fill_in :percentage ,with: 25
    fill_in :quantity_threshold ,with: 4
    click_button "Create Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts")

    new_bulk_discount_id = BulkDiscount.last.id

    expect(page).to have_content("#{new_bulk_discount_id}")
  end

  it "wont create new discount if filled incorrectly" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"

    click_link("Create New Discount")

    fill_in :percentage ,with: 25
    fill_in :quantity_threshold ,with: ""
    click_button "Create Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/new")

    expect(page).to have_content("Error")
  end
end
