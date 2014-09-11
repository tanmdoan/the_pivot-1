require 'rails_helper'

describe 'when viewing the loan requests' do

  let(:user1) { User.create(id: 1, first_name: 'Nando', last_name: 'Hasselhoff', email: 'yourmom@aol.com', password: '123', password_confirmation: '123', role: "borrower") }
  let(:user2) { User.create(id: 2, first_name: 'Windy', last_name: 'Buffet', email: 'yourdad@aol.com', password: '123', password_confirmation: '123', role: "lender") }

  context 'as a guest' do

    before(:each) do
      user1
      user2
      visit users_path
    end

    it 'should exist' do
      expect(page.status_code).to eq 200
    end

    it 'should see existing borrowers' do
      expect(page).to have_content 'Nando'
    end

    it 'should not see existing lenders' do
      expect(page).to have_content 'Find a Borrower'
      expect(page).to_not have_content 'Buffet'
    end

    it 'has a link to a borrower' do
      expect(page).to have_link 'Nando Hasselhoff', href: user_path(user1)
    end

    it 'links successfully to item' do
      click_link 'Nando Hasselhoff'
      expect(current_path).to eq(user_path(user1))
      expect(page).to have_content 'Nando Hasselhoff'
    end
  end
end
