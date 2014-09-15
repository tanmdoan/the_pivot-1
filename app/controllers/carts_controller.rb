class CartsController < ApplicationController
  def show
    @loans = Loan.where(id: current_cart.keys).decorate
  end

  def update
    loan_id = params[:cart][:loan_id]
    quantity = params[:cart][:quantity].to_i
    #
    # if loan = Loan.find_by(id: loan_id, enabled: true)
    #   current_cart.store(loan_id, quantity)
      current_cart.save

      # if current_cart.quantity(loan_id) > 0
      #   if current_cart.new?(loan_id)
      #     flash[:success] = 'Added to your cart. (You can afford that?)'
      #   else
      #     flash[:success] = 'Updated quantity for loan.'
      #   end
      # else
      #   flash[:success] = "'#{loan.title}' has been removed from your cart."
      #   redirect_to cart_path
      #   return
      # end
    # else
    #   flash[:error] = 'That loan is no longer available.'
    # end

    redirect_to :back
  end

  def destroy
    loan = Loan.find_by(id: params[:cart][:loan_id])
    current_cart.delete(loan.id)

    flash[:success] = "'#{loan.title}' has been removed from your cart."
    redirect_to cart_path
  end
end
