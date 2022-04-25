class Public::AddressesController < ApplicationController

  def create
    address = Address.new(addresses_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to addresses_path
  end

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(addresses_params)
    redirect_to edit_address_path(@address.id)
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  def addresses_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
