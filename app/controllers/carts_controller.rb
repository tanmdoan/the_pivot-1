class CartsController < ApplicationController
  def show
    @loans = Loan.where(id: current_cart.keys).decorate
  end

  # def new
  #   loan_id = params[:cart][:loan_id]
  #   amount = params[:cart][:amount].to_i
  #   user_id = current_user.id
  #
  #   contribution = Contribution.new(loan_id: loan_id, amount: amount, user_id: user_id)
  #
  #   if contribution.save
  #     flash[:success] = 'Added to your cart. (You\'re a good person)'
  #   else
  #     flash[:success] = 'Sorry, buster.'
  #   end
  # end

  def update
    loan_id = params[:cart][:loan_id]
    amount = params[:cart][:amount].to_i
    user_id = current_user.id

    contribution = Contribution.new(loan_id: loan_id, amount: amount, user_id: user_id)

    if contribution.that_shits_ok?
      contribution.save
      current_cart << contribution
    else
      flash[:success] = 'Your contribution exceeds the loan amount left!'
    end

    redirect_to :back
  end

  def destroy
    loan = Loan.find_by(id: params[:cart][:loan_id])
    current_cart.delete(loan.id)

    flash[:success] = "You will not contribute to '#{loan.title}'."
    redirect_to cart_path
  end
end
