
class LoansController < ApplicationController
	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def index
		@categories = Category.all.decorate
		@q = Loan.search(params[:q])
		if params[:q]
			@loans = @q.result.includes(:categories).all
		else
		  @loans = Loan.includes(:categories).all
	  end

		@loans = @loans.decorate

		# group by category
		@loans_by_category = {}
		@loans.each do |loan|
			loan.categories.each do |category|
				@loans_by_category[category.name] ||= []
				@loans_by_category[category.name] << loan
			end
		end
	end

	private

	def loans
		@loans = Loan.all
	end
end
