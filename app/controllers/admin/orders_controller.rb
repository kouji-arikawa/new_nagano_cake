class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.status == "payment_confirmation"
      @order_items = order.order_items
      @order_items.each do |order_item|
      order_item.update(making_status: 2)
     end
    end
    # 1. 「注文ステータスが入金確認だったら」というif文
    # 2. 注文に紐づく、注文商品一覧を取得
    # 3. 注文商品一覧一つ一つのデータに対して、製作ステータスを「制作待ち」に更新する
    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
