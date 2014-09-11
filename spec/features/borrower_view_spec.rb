require 'rails_helper'

describe 'When viewing the borrower dashboard' do
	context "as a borrower" do

		before(:each) do
			register_and_login_as_borrower
		end

		it "has a dashboard with loans specific to that borrower" do
			visit borrower_path
			expect(page).to have_content("Loans")
		end

		it "has a link to create a loan" do
			visit borrower_path
			expect(page).to have_link("Apply")
		end

		it "has the borrower's profile" do
			visit borrower_path
			expect(page).to have_content("Gen")
			expect(page).to have_content("Casagrande")
			expect(page).to have_content("yourdad123@aol.com")
		end
	end

end
