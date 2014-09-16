class OrdersController < ApplicationController
  before_filter :check_user

  def index
    @orders = current_user.orders.decorate
  end

  def show
    @order = current_user.orders.includes([:order_loans, :loans]).find_by(id: params[:id])

    if @order
      @order = @order.decorate
    else
      not_found
    end
  end

  def new
    if current_cart.empty?
      redirect_to cart_path, notice: 'Your cart is empty.'
    else
      @order = Order.new
      @order.address = Address.new
      @loans = Loan.where(id: current_cart.keys).decorate
      @addresses = current_user.addresses.decorate
    end
  end

  def create
    @order = current_user.orders.new_with_loans(current_cart)

    if @order.charge(params[:stripeToken]) && @order.save!
      current_cart.clear
      CartSession.new(session).clear
      flash[:success] = 'Your order has been received.'
      redirect_to order_path(@order)
    else
      @addresses = current_user.addresses.decorate
      @loans = Loan.where(id: session[:cart].keys).decorate
      render :new
    end
  end

  def cancel
    @order = current_user.orders.find_by(id: params[:order_id])

    if @order
      @order.cancel
      redirect_to orders_path
    else
      not_found
    end
  end

  private

  # def order_params
  #   # params.require(:order).permit(:order_type, :address_id, address_attributes: [:street, :unit, :city, :state, :zip])
  # end
  #
  # def merged_params
  #   adjusted_params = order_params
  #   if adjusted_params['address_attributes']
  #     adjusted_params['address_attributes']['user_id'] = current_user.id
  #   end
  #   adjusted_params
  # end

end
