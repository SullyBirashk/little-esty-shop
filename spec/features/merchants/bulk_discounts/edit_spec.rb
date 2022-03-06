require 'rails_helper'

RSpec.describe "Editing Merchant Bulk Discounts" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder_Miflin")

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    @discount_3 = @merchant_2.bulk_discounts.create!(percentage: 10, quantity_threshold: 3)
  end

  it "can edit a bulk discount" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}"

    within ".edit_discount" do
      expect(page).to have_link("Edit Bulk Discount #{@discount_1.id}")
    end

    click_link("Edit Bulk Discount #{@discount_1.id}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}/edit")

    fill_in :percentage ,with: 25
    fill_in :quantity_threshold ,with: 4
    click_button "Update Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}")

    within ".attributes" do
      expect(page).to have_content(25)
      expect(page).to have_content(4)
    end
  end
end
