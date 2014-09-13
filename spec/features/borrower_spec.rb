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

    let(:borrower) { User.create(first_name: "Gen", last_name: "Casagrande", email: "yourmom123@aol.com",
                  password: "password", password_confirmation: "password", role: "borrower", nickname: "gen") }


    before(:each) do
      @user = User.create!(first_name: 'Nando', last_name: 'Hasselhoff', email: 'yourmom@aol.com', password: '123', password_confirmation: '123', role: "borrower")
      login(email: 'yourmom@aol.com', password: '123')
    end

    it "has a borrower dashboard" do
      expect(current_path).to eq(borrower_path)
      expect(page).to have_content("Borrower Dashboard")
      expect(page).to have_content("Loans")
    end

    it 'can view their loans' do
      click_on "My Loans"
      expect(page).to have_content "My Loans"
      expect(page).to have_content "Title"
      expect(page).to have_content "Description"
      expect(page).to have_content "Amount"
      expect(page).to have_content "Categories"
      expect(page).to have_content "Status"
    end

    it 'can view date joined, first name, last name, email, and nickname' do
      click_on "Logout"
      register
      login
      expect(page).to have_content(borrower.first_name)
      expect(page).to have_content(borrower.last_name)
      expect(page).to have_content(borrower.email)
    end

    it 'can view edit personal info' do
      click_on "Edit Info"
      expect(current_path).to eq edit_user_path(@user)
      expect(page).to have_button "Update"
    end

    it 'can edit account info' do
      click_on "Edit Info"
      fill_in 'First name', with: 'Carlos'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_on 'Update'
      expect(current_path).to eq(borrower_path)
      expect(page).not_to have_content('Nando')
      expect(page).to have_content('Carlos')
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
