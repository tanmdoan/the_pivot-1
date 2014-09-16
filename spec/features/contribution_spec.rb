require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a lender' do
		let(:loan) { Loan.create(id: 1,
														title: 'Buy a cow',
														description: 'Need to buy a milking cow for our farm',
														amount: 50000,
														requested_by: "2014-09-10 13:43:00 -0600",
														repayments_begin: "2014-09-10 13:43:00 -0600",
														monthly_payment: 100000,
														user_id: 1
														) }

		before(:each) do
			register_and_login_as_lender
      lender = User.last
			loan
      # contribution = Contribution.create(user_id: lender.id, loan_id: 1, amount: 25)
			category = Category.create!(id: 1, name: "Agriculture")
      LoanCategory.create!(loan_id: 1, category_id: 1)
      # loan_contribution = LoanContribution.create(contribution_id: contribution.id, loan_id: loan.id)
		end

# contributions mean that less money is needed to fulfill a loan
# can only make a contribution if the amount is less than what is owed
# cannot contribute more than requested for loan
# can only contribute to loans with status request

		it 'can choose a loan and make a contribution to it' do
			visit loans_path
			click_on "Loan Now"
		end

		xit 'can edit an order' do
			click_link "Edit"
			fill_in "Order type", with: "delivery"
			click_button "Update Order"
			expect(page).to have_content("delivery")
		end

    xit 'can see borrower name from contribution page' do
      expect(page).to have_content('your dad')
    end

    xit 'can see borrower name, and loan deets on details page' do
      click_link 'Details'
      expect(page).to have_content(loan.borrower.name)
      expect(page).to have_content(loan.amount)
      expect(page).to have_content(loan.title)
      expect(page).to have_content(loan.description)
    end
  end
end
