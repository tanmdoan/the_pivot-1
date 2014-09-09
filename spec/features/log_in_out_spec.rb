require 'rails_helper'

describe 'Logging in' do

  before(:each) { User.create email: 'yourmom123@aol.com',
                  password: '123',
                  password_confirmation: '123',
                  first_name: 'Jon',
                  last_name:  'Michael',
                  role: "borrower"}

  context 'as a borrower' do
    it 'logs in as a borrower successfully' do
      login
      expect(page).to_not have_content 'Login'
      expect(page).to     have_content 'Logout'
    end

    it 'cannot log in with an invalid password' do
      login(password: '1234')
      expect(page).to have_content 'Invalid username or password.'
    end

    it 'can try to log in to a non-existent account without blowing up' do
      login(email: 'not@real.com', password: '123')
      expect(page).to have_content 'Invalid username or password.'
    end
  end

  context 'as a borrower' do
    it 'logs out' do
      login
      click_on 'Logout'
      expect(page).to     have_content 'Login'
      expect(page).to_not have_content 'Logout'
    end
  end
end
