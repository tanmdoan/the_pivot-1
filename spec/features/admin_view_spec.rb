require 'rails_helper'

describe 'When viewing the admin dashboard' do
	context "as an admin" do

		before(:each) do
			register_as_admin
			login_as_admin
		end

		xit "has a dashboard with orders" do
			visit '/admin/'

			expect(page).to have_content("Orders")
		end

		xit 'links to admin/categories from the nav bar' do
			visit '/admin/'
			click_link('Categories')
			expect(current_path).to eq(admin_categories_path)
		end
	end

end
