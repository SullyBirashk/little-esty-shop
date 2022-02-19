require 'rails_helper'


RSpec.describe 'the merchant item index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
  end

  it "will show merchants item names" do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_4.name)
  end
end