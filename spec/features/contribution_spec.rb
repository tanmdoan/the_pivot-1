require 'rails_helper'

describe 'when viewing the loans' do
  before(:each) do
    register_and_login_as_a_lender
  end

	context 'as a lender' do
    let(:lender) { User.find_by(role: "lender") }
		let(:contribution)  { Contribution.create(user_id: lender.id, loan_id: 1, amount: 25) }
		let(:loan) { Loan.create(title: 'Cow1', description: 'Clearly, the best cow', price: 4300) }
		let(:loan_contribution) { LoanContribution.create(contribution_id: contribution.id, loan_id: loan.id, lender_id: lender.id, amount: 2) }

		before(:each) do
      lender
      contribution
      loan
      loan_contribution
			visit lender_contributions_path(lender)
		end

		xit 'displays orders' do
			expect(page).to have_content("pickup")
			expect(page).to have_content("ordered")
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
