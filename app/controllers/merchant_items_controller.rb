class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if params[:_method] == 'patch'
      item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}", notice: "Item Successfully Updated"
    else params[:_method] == 'put'
      item.update(status: (params[:status].to_i))
      redirect_to "/merchants/#{merchant.id}/items"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create!(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :status)
    end
end
