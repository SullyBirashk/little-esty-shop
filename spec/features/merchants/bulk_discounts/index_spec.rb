require 'rails_helper'

RSpec.describe "Merchant Bulk Discounts Index Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder_Miflin")

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    @discount_3 = @merchant_2.bulk_discounts.create!(percentage: 10, quantity_threshold: 3)
  end

  it "Shows Upcoming Holidays" do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"
save_and_open_page
    within ".upcoming_holidays" do
      expect(page).to have_content("Upcoming Holidays:")
      expect(page).to have_content("Good Friday")
      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("Juneteenth")
      #expect(page).to_not have_content("New Year's Day")
    end
  end
end
