class Borrower::OrdersController < BorrowersController
  before_action :check_borrower, only: [:index]

	def index
    @orders = current_user.loans.orders.includes([:user, :order_items]).all.decorate
	end

	def show
    @order = current_user.loans.orders.includes([:items]).find(params[:id]).decorate
	end

	# def edit
  #   @order = Order.includes([:order_items, :items]).find(params[:id]).decorate
	# end
  #
	# def ordered
  #   @orders = Order.ordered.decorate
	# 	render :index
	# end
  #
	# def paid
  #   @orders = Order.paid.decorate
	# 	render :index
	# end
  #
	# def completed
  #   @orders = Order.completed.decorate
	# 	render :index
	# end
  #
	# def cancelled
  #   @orders = Order.cancelled.decorate
	# 	render :index
	# end
  #
	# def update
	# 	@order = Order.find(params[:id])
	# 	if @order.update(order_params)
	# 		redirect_to borrower_orders_path
	# 	else
	# 		render :edit
	# 	end
	# end
  #
	# def cancel
	# 	@order = Order.find(params[:order_id])
	# 	@order.cancel
	# 	redirect_to borrower_orders_path
	# end
  #
	# def update_status
	# 	@order = Order.find(params[:order_id])
	# 	@order.update_status
	# 	redirect_to borrower_orders_path
	# end
  #
	# def remove_item
	# 	@order = Order.find(params[:order_id])
	# 	@order.remove_item(params[:item_id])
	# 	redirect_to edit_borrower_order_path(@order)
	# end

	private

	def order_params
		params.require(:order).permit(:user_id, :order_type, :address_id, :status, :total)
	end
end
