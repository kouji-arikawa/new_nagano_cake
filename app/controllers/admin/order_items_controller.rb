class Admin::OrderItemsController < ApplicationController

  def update
    order_item = OrderItem.find(params[:id])
    order = Order.find(params[:order_id])
    order_item.update(order_item_params)
    if order.order_items.count == order.order_items.where(making_status: 4).count
      order.update(status: "in_preparation")
    end
    if order_item.making_status == 3
      @order = order_item.order
      @order.status
        @order.update(status: "under_construction")
    end
    # 1. 注文商品の制作ステータスが製作中だったら」というif文
    # 2. 注文商品に紐づく注文データを取得
    # 3. 注文データのステータスを制作中に変更
    redirect_to admin_order_path(order_item.order_id)
  end

  private
  def order_item_params
    params.require(:order_item).permit(:item_id, :order_id, :price_tax, :amount, :making_status)
  end
end
