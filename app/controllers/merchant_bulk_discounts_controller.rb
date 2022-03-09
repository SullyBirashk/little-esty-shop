class MerchantBulkDiscountsController < ApplicationController

  def index
    @holiday_names = UpcomingHolidaysFacade.find_holidays(3)
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new = merchant.bulk_discounts.create(bulk_discount_params)

    if new.save
      redirect_to "/merchants/#{merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: #{error_message(new.errors)}"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])

    if bulk_discount.update(bulk_discount_params)
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{bulk_discount.id}"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{bulk_discount.id}/edit"
      flash[:alert] = "Error: #{error_message(new.errors)}"
    end
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end
