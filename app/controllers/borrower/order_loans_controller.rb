class Borrower::OrderLoansController < BorrowersController
  def destroy
    @order_loan = OrderLoan.find(params[:id])
    order = Order.find(@order_loan.order_id)
    @order_loan.destroy
    redirect_to edit_borrower_order_path(order)
  end

  def update
    @order_loan = OrderLoan.find(params[:id])
    order = Order.find(@order_loan.order_id)
    @order_loan.update(order_loan_params)
    redirect_to edit_borrower_order_path(order)
  end

  private

  def order_loan_params
    safe_params = params.require(:order_loan).permit(:order_id, :loan_id, :quantity, :unit_price)
    update_params(safe_params)
  end

  def update_params(params)
    params[:unit_price] = (params[:unit_price].to_d * 100).to_i
    params
  end
end
