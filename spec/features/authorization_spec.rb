require 'rails_helper'

describe 'Authorization', type: :feature do
  context 'As a guest' do
    xit 'cannot view a page requiring authorization' do
      visit borrower_orders_path

      expect(current_path).to eq login_path
      expect(page).to have_content 'You must be logged in to access that.'
    end
  end

  context 'As a borrower' do
    xit 'can view a page requiring authorization' do
      register_as_borrower
      login_as_borrower

      visit borrower_orders_path
      expect(current_path).to eq borrower_orders_path
    end
  end
end
