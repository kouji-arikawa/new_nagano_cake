class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new
    @order.customer_id = current_customer.id
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    @order.name = params[:order][:name]
    @order.shoping_cost = params[:order][:shoping_cost]
    @order.total_payment = params[:order][:total_payment]
    @order.payment_method = params[:order][:payment_method]
    if @order.save
      @cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.price_tax = cart.item.price
        order_item.save
      end
      redirect_to complete_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new
    @order.shoping_cost = 800
    if params[:order][:address_number] == "1"
      @order.payment_method = params[:order][:payment_method]
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @order.postal_code = current_customer.post_code
    elsif params[:order][:address_number] == "2"
      if Address.exists?(id: params[:order][:registered])
        @order.payment_method = params[:order][:payment_method]
        @order.name = Address.find(params[:order][:registered]).name
        @order.address = Address.find(params[:order][:registered]).address
        @order.postal_code = Address.find(params[:order][:registered]).postal_code
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new
      address_new.name = params[:order][:name]
      address_new.address = params[:order][:address]
      address_new.postal_code = params[:order][:postal_code]
      @order.payment_method = params[:order][:payment_method]
      if address_new.save
      else
        render :new
      end
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def index
    @order = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:total_price, :address_number, :registered, :address, :name, :customer_id, :postal_code, :shoping_cost, :total_payment, :payment_method, :status)
  end
end