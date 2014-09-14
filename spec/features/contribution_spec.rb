require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a lender' do
		let(:loan) { Loan.create(title: 'Cow1', description: 'Clearly, the best cow', amount: 4300) }

		before(:each) do
			register_and_login_as_lender
      lender = User.last
      contribution = Contribution.create(user_id: lender.id, loan_id: 1, amount: 25)
      loan
      loan_contribution = LoanContribution.create(contribution_id: contribution.id, loan_id: loan.id)
		end

		it 'can choose a loan and make a contribution to it' do
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
