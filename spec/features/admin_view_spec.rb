require 'rails_helper'

describe 'When viewing the borrower dashboard' do
	context "as an borrower" do

		before(:each) do
			register_as_borrower
			login_as_borrower
		end

		xit "has a dashboard with orders" do
			visit '/borrower/'

			expect(page).to have_content("Orders")
		end

		xit 'links to borrower/categories from the nav bar' do
			visit '/borrower/'
			click_link('Categories')
			expect(current_path).to eq(borrower_categories_path)
		end
	end

end
