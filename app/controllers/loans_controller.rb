class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end
end
