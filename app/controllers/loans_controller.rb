class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def index
		@loans = loans
	end

	private

	def loans
		@loans = Loan.all
	end
end
