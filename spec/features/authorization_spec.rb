require 'rails_helper'

describe 'Authorization', type: :feature do
  context 'As a guest' do
    it 'cannot view a page requiring authorization' do
      visit borrower_path

      expect(current_path).to eq login_path
      expect(page).to have_content 'You must be logged in to access that.'
    end
  end

  context 'As a borrower' do
    it 'can view a page requiring authorization' do
      register_as_borrower
      login_as_borrower

      visit borrower_path
      expect(current_path).to eq borrower_path
    end
  end

  xit 'can not view other users loans' do
    click_on "My Loans"
    expect(page).to have_content "My Loans"
    #visit other loan path expect flash message
  end

  xit "needs more tests?" do
  end
end
