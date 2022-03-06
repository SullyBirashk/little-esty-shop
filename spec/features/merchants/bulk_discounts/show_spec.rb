require 'rails_helper'

RSpec.describe "Merchant Bulk Discounts Show Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder_Miflin")

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    @discount_3 = @merchant_2.bulk_discounts.create!(percentage: 10, quantity_threshold: 3)
  end

  it "Show page shows attributes" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}"

    within ".attributes" do
      expect(page).to have_content("#{@discount_1.percentage}")
      expect(page).to have_content("#{@discount_1.quantity_threshold}")

      expect(page).to_not have_content("#{@discount_2.percentage}")
      expect(page).to_not have_content("#{@discount_2.quantity_threshold}")
    end
  end
end
