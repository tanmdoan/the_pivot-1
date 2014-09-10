require 'rails_helper'

describe 'Redirect after login', type: :feature do
  context 'After accessing a protected page' do
    xit 'returns to the referring page' do
      register_as_borrower
      click_link 'Logout'

      visit borrower_orders_path
      fill_in 'Email', with: 'yourdad123@aol.com'
      fill_in 'Password', with: '123'
      click_button 'Login'
      expect(current_path).to eq borrower_orders_path
    end
  end

  context 'From an unprotected page' do
    xit 'redirects to order dashboard' do
      register_as_borrower
      login_as_borrower

      expect(current_path).to eq borrower_orders_path
    end
  end
end
