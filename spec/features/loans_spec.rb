require 'rails_helper'

describe 'when viewing the loans' do

	let(:loan) { Loan.create(title: 'Buy a cow',
													description: 'Need to buy a milking cow for our farm',
													amount: 50000,
													requested_by: "2014-09-10 13:43:00 -0600",
													repayments_begin: "2014-09-10 13:43:00 -0600",
													monthly_payment: 1000
													) }

	context 'as a borrower' do

		before(:each) do
			register_and_login_as_borrower
			loan
			visit borrower_loans_path
		end

		it 'should exist' do
			expect(page.status_code).to eq 200
		end

		xit 'should see existing loans' do
			expect(page).to have_content 'The Awesome Donut'
			expect(page).to have_content 'Clearly, the best donut you\'ve ever had.'
			expect(page).to have_content '$45.00'
		end

		xit 'has a link to an loan' do
			expect(page).to have_link 'The Awesome Donut', href: borrower_loan_path(loan)
		end

		xit 'links successfully to loan' do
			click_link 'The Awesome Donut'
			expect(current_path).to eq(borrower_loan_path(loan))
			expect(page).to have_content 'The Awesome Donut'
			expect(page).to have_content 'Clearly, the best donut you\'ve ever had.'
		end

		xit 'shows the category associated with an loan' do
			loan = Loan.create(title: "Shitty Donut", description: "A Mistake", price: 0)
			category = Category.create(name: "Savory")
			loan.categories << category
			category.loans << loan
			visit borrower_loans_path
			expect(page).to have_content "Shitty Donut"
			expect(page).to have_content "Savory"
		end

		xit 'links successfully to loan' do
			click_link 'The Awesome Donut'
			expect(current_path).to eq(borrower_loan_path(loan))
			expect(page).to have_content 'The Awesome Donut'
			expect(page).to have_content 'Clearly, the best donut you\'ve ever had.'
		end

		xit 'shows the category associated with an loan' do
			loan = Loan.create(title: "Shitty Donut", description: "A Mistake", price: 0)
			category = Category.create(name: "Savory")
			loan.categories << category
			category.loans << loan
			visit borrower_loans_path
			expect(page).to have_content "Shitty Donut"
			expect(page).to have_content "Savory"
		end

		xit 'can create a new loan' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Fancy New Donut"
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Price", with: "800"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'Fancy New Donut'
			expect(page).to have_content "It's pretty fancy"
		end

		xit	'cannot create an loan without a title' do
			visit new_borrower_loan_path
			fill_in "Title", with: ""
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Price", with: "800"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		xit'cannot create an loan without a description' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: ""
			fill_in "Price", with: "800"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		xit	'cannot create an loan without a price' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: ""
			fill_in "Price", with: ""
			click_button "Create Loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		xit 'can update an loan' do
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800)
			visit edit_borrower_loan_path(loan)
			fill_in "Title", with: "Fancy New Donut"
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Price", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'Fancy New Donut'
			expect(page).to have_content "It's pretty fancy"
			expect(page).not_to have_content 'OMG Donut'
			expect(page).not_to have_content "Just like, wow."
		end

		xit 'cannot update an loan without a title' do
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800)
			visit edit_borrower_loan_path(loan)
			fill_in "Title", with: ""
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Price", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(loan))
			expect(page).to have_content 'blank'
		end

		xit 'cannot update an loan without a description' do
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800)
			visit edit_borrower_loan_path(loan)
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: ""
			fill_in "Price", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(loan))
			expect(page).to have_content 'blank'
		end

		xit 'cannot update an loan without a price' do
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800)
			visit edit_borrower_loan_path(loan)
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: "Tasty"
			fill_in "Price", with: ""
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(loan))
			expect(page).to have_content 'blank'
		end

		xit 'can delete and loan' do
			loan = Loan.create(title: "Shitty Donut", description: "A Mistake", price: 0)
			visit borrower_loan_path(loan)
			click_link "Delete"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).not_to have_content "Shitty Donut"
			expect(page).not_to have_content "A Mistake"
		end

		xit 'shows categories on edit loan page' do
			category = Category.create(id: 1, name: 'Test Category')
			category = Category.create(id: 2, name: 'Testy Category')
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800, category_ids: ['1', '2'])
			visit edit_borrower_loan_path(loan)
			expect(page).to have_content "Test Category"
			expect(page).to have_content "Testy Category"
		end

		xit 'has can delete a category from loan' do
			category = Category.create(name: 'Test Category')
			loan = Loan.create(title: "OMG Donut", description: "Just like, wow.", price: 1800)
			LoanCategory.create(loan: loan, category: category)

			visit edit_borrower_loan_path(loan)
			expect(page).to have_content "Test Category"
			click_link "Delete"
			expect(page).to_not have_content "Delete"
		end

		xit 'can add a category to an loan' do
			Category.create(name: 'Test Category')
			Category.create(name: 'Testy Cat')
			Category.create(name: 'Tasty')

			visit edit_borrower_loan_path(loan)
			expect(page).to_not have_content 'Delete'
			click_link "Tasty"
			expect(page).to have_content 'Delete'
		end

		xit 'can retire an loan from being sold' do
			expect(page).to have_link('Retire')
			click_link 'Retire'
			expect(page).not_to have_link('Retire')
		end

		xit 'has a link to activate a retired loan' do
			expect(page).not_to have_link('Activate')
			click_link 'Retire'
			expect(page).to have_link('Activate')
			expect(page).not_to have_link('Retire')
		end

		xit 'can activate a retired loan' do
			click_link 'Retire'
			click_link 'Activate'
			expect(page).to have_link('Retire')
			expect(page).not_to have_link('Activate')
		end
	end
end
