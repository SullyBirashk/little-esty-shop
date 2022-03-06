class MerchantBulkDiscountsController < ApplicationController

  def index
    @holiday_names = UpcomingHolidaysFacade.find_holidays
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold)
  end


end
