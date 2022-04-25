class Public::CartItemsController < ApplicationController

  def new
    @cart_item = CartItem.new
  end

  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
