require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it { should validate_presence_of(:discount_rate) }
    it { should validate_presence_of(:threshold) }
    it { should validate_presence_of(:merchant_id) }
  end
end
