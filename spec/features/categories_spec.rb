require 'rails_helper'

xdescribe 'when viewing the categories' do
	context 'as a guest' do

		let(:category) { Category.create(id: 1,
																		name: 'Savory'
																		) }
		let(:loan) { Loan.create(id: 1,
														title: 'Buy a cow',
														description: 'Need to buy a milking cow for our farm',
														amount: 50000,
														requested_by: "2014-09-10 13:43:00 -0600",
														repayments_begin: "2014-09-10 13:43:00 -0600",
														monthly_payment: 1000,
														user_id: 1
														) }
		let(:loan_category) { LoanCategory.create(loan_id: 1, category_id: 1) }

		before(:each) do
			category
			loan_category
			loan
			visit loans_path
		end


		it 'cannnot edit, delete, or add categories' do
			expect(page).not_to have_content('Edit')
			expect(page).not_to have_content('Delete')
			expect(page).not_to have_content('Add Category')
		end

		it "can see loans by categories" do
			expect(page).to have_content(category.name)
			expect(page).to have_content(loan.title)
			expect(page).to have_content(loan.amount_in_dollars)
		end
	end
end
