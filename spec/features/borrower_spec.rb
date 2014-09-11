require 'rails_helper'
include ApplicationHelper

describe 'borrower experience' do
  context 'as a guest' do
    it 'can see a register link' do
      visit root_path
      expect(page).to have_link 'Register'
    end

    it 'can register a new borrower account' do
      register
      expect(current_path).to eq borrower_path
      expect(User.count).to eq 1
      expect(User.last.role).to eq "borrower"
    end

    it 'cannot register without an email' do
      register(email: nil)
      expect(page).to have_content "Email can't be blank"
    end

    it 'cannot register with an email already registersed' do
      register
      click_on 'Logout'
      register
      expect(page).to have_content "Email has already been taken"
    end

    it 'cannot register with an invalid email address' do
      register(email: '^$%^%#$@#$^%$^.com')
      expect(page).to have_content "Email is invalid"
    end

    it 'cannot register without a password' do
      register(password: nil)
      expect(page).to have_content "Password can't be blank"
    end

    it 'cannot register without a password confirmation' do
      register(password_confirmation: nil)
      expect(page).to have_content "Password confirmation can't be blank"
    end

    it 'cannnot register when passwords do not match' do
      register(password: '123', password_confirmation: '1234')
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    it 'stays logged in after registration' do
      register
      expect(page).to have_link "Logout"
    end

    it 'gives me confirmation after successful registration' do
      register
      expect(page).to have_content "Registration successful"
    end

    it 'cannot backdoor to borrower pages' do
      visit borrower_loans_path
      expect(current_path).to eq(login_path)
      visit borrower_categories_path
      expect(current_path).to eq(login_path)
    end

    it 'cannot register with a nickname of 1 character or greater than 32 characters' do
      visit root_path
      click_link 'Register'
      register(nickname: 'o')
      expect(page).to have_content('1 error prohibited this user from being saved')
    end
  end

  context 'as a registered borrower' do

    let(:borrower) { User.create(first_name: "Nan", last_name: "Hass", email: "yourmommy@aol.com",
                  password: "password", password_confirmation: "password", role: "borrower", nickname: "Nandozer") }


    before(:each) do
      register(first_name: 'Nando', last_name: 'Hasselhoff', email: 'yourmom@aol.com', password: '123', password_confirmation: '123')
      login(email: 'yourmom@aol.com', password: '123')
      borrower
    end

    it "has a borrower dashboard" do
      expect(current_path).to eq(borrower_path)
      expect(page).to have_content("Borrower Dashboard")
      expect(page).to have_content("Loans")
    end

    xit 'can view their loans' do
      click_on "My Loans"
      expect(page).to have_content "My Loans"
      expect(page).to have_content "Pending"
      expect(page).to have_content "Fulfilled"
      expect(page).to have_link "Details"
    end

    xit 'can view their user profile' do
      click_on "Profile"
      expect(page).to have_content "My Info"
      expect(page).to have_link "Edit"
    end

    xit 'can link to a details page for each loan' do
      click_on "My Loans"
      click_link 'Details'
      expect(current_path).to eq(loan_path(loan))
    end

    xit 'can see all details of an individual loan' do
      click_on "My Loans"
      click_link 'Details'
      expect(page).to have_content(loan.title)
      expect(page).to have_content(loan.description)
      expect(page).to have_content(loan.amount)
      expect(page).to have_content(loan.end_date)
      expect(page).to have_content(loan.start_date)
      expect(page).to have_content(loan.repay_start)
    end

    xit 'can view date joined, first name, last name, email, and nickname' do
      click_on 'Profile'
      expect(page).to have_content(format_date(borrower.created_at))
      expect(page).to have_content(borrower.first_name)
      expect(page).to have_content(borrower.last_name)
      expect(page).to have_content(borrower.email)
      expect(page).to have_content(borrower.nickname)
    end

    xit 'can edit account info' do
      click_on 'Profile'
      click_on 'Edit'
      fill_in 'First name', with: 'Carlos'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_on 'Update User'
      expect(current_path).to eq(account_path)
      expect(page).not_to have_content('Nando')
      expect(page).to have_content('Carlos')
    end

    xit 'cannot ad a nickame of 1 characer' do
      click_on 'Profile'
      click_on 'Edit'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      fill_in 'Nickname', with: 'a'
      click_on 'Update User'
      expect(page).to have_content 'minimum is 2 characters'
    end

    xit 'cannot ad a nickame of > 32 characers' do
      click_on 'Profile'
      click_on 'Edit'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      fill_in 'Nickname', with: (0..33).map{'a'}.join
      click_on 'Update User'
      expect(page).to have_content 'maximum is 32 characters'
    end
  end
end
