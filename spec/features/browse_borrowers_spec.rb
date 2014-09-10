require 'rails_helper'

describe 'when viewing the items' do

  let(:user) { User.create(id: 1, first_name: 'Nando', last_name: 'Hasselhoff', email: 'yourmom@aol.com', password: '123', password_confirmation: '123', role: "borrower") }

  context 'as a guest' do

    before(:each) do
      register(first_name: 'Nando', last_name: 'Hasselhoff', email: 'yourmom@aol.com', password: '123', password_confirmation: '123')
      visit users_path
    end

    it 'should exist' do
      expect(page.status_code).to eq 200
    end

    it 'should see existing borrowers' do
      expect(page).to have_content 'Find a Borrower'
      expect(page).to have_content 'Nando'
      # expect(page).to have_content 'bio'
    end

    xit 'should not see existing lenders' do
      expect(page).to have_content 'Find a Borrower'
      expect(page).to_not have_content 'Buffet'
    end

    it 'has a link to an item' do
      expect(page).to have_link 'Nando Hasselhoff', href: user_path(user)
    end

    it 'links successfully to item' do
      click_link 'Nando Hasselhoff'
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content 'Nando Hasselhoff'
    end
  end
end
