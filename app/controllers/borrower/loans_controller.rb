class Borrower::LoansController < BorrowersController
	def index
    @loans = current_user.loans.includes(:categories).all.decorate
	end

	def dashboard
		@loans = current_user.loans.all
	end

	def show
    @loan = Loan.find(params[:id]).decorate
	end

	def new
		@loan = Loan.new
	end

	def create
		@loan = current_user.loans.new(loan_params)
		if @loan.save
			redirect_to borrower_loans_path
		else
			render :new
		end
	end

	def edit
		# FIXME fix security issue
    @loan = Loan.find(params[:id]).decorate
    @categories = Category.all
	end

	def update
    @loan = Loan.find(params[:id]).decorate
		if @loan.update(loan_params)
			redirect_to borrower_loans_path
		else
			render :edit
		end
	end

	def delete_category
		loan = Loan.find(params[:loan_id])
		loan.remove_category(params[:category_id])
		redirect_to edit_borrower_loan_path(loan)
	end

	def add_category
		loan = Loan.find(params[:loan_id])
		unless LoanCategory.find_by(loan_id: params[:loan_id], category_id: params[:category_id])
			LoanCategory.create(loan_id: params[:loan_id], category_id: params[:category_id])
		end
		redirect_to edit_borrower_loan_path(loan)
	end

	def destroy
		Loan.find(params[:id]).destroy
		redirect_to borrower_loans_path
	end

	def retire
		@loan = Loan.find(params[:loan_id])
		@loan.retire
		redirect_to borrower_loans_path
	end

	private

	def loan_params
		safe_params = params.require(:loan).permit(:title, :description, :amount, :image, :repayments_begin, :requested_by, :monthly_payment)
    update_params(safe_params)
	end

	def update_params(columns)
    columns[:amount] = (columns[:amount].to_d * 100).to_i unless columns[:amount].empty?
		columns
	end
end
