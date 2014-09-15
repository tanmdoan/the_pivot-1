require 'rails_helper'

describe 'Checking out', type: :feature do
  context 'with an empty cart' do
    xit 'sees an error message' do
      register
      login
      visit new_order_path
      expect(page).to have_content 'Your are not contributing to any loans. How does that feel?'
    end
  end
  #
  context 'with a populated cart' do
    before(:each) do
      category = Category.create(name: 'Donuts')
      category.loans.create(title: 'Buy a cow',
                            description: 'Need to buy a milking cow for our farm',
                            amount: 50000,
                            requested_by: "2014-09-10 13:43:00 -0600",
                            repayments_begin: "2014-09-10 13:43:00 -0600",
                            monthly_payment: 1000,
                            user_id: @borrower.id
                            )
      register
      login

      visit categories_path
      first(:button, 'Add to Cart').click
      first(:button, 'Add to Cart').click
      first(:button, 'Add to Cart').click

      visit new_order_path
    end
  #
    xit 'sees the cart loans' do
      expect(page).to have_content 'cow'
      expect(page).to have_content '$500.00'
    end
  #
    context 'paying with credit card' do
      xit 'can create a new order' do

        fill_in :credit_card, with: 4242424242424242
        fill_in :exp_year, with: 2015
        fill_in :exp_month, with: 2
        fill_in :cvv, with: 123

        click_button 'Create Order'

        expect(page).to have_content 'Your order has been received.'
        expect(page).to have_content '$500.00'
      end
    end
  end
end
