class MerchantBulkDiscountsController < ApplicationController

  def index
    @holiday_names = UpcomingHolidaysFacade.find_holidays
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show

  end
end
