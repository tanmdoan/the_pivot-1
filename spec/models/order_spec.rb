require 'rails_helper'

RSpec.describe Order, type: :model  do
	let(:order) { Order.new(user_id: 1, order_type: "delivery", payment_type: 'cash', address_id: 3, status: "ordered") }

	it 'is valid' do
		expect(order).to be_valid
	end

	it { should validate_presence_of(:user_id) }

	it 'has an array of order loans' do
		expect(order.order_loans).to eq([])
	end

	it 'has an array of loans' do
		expect(order.loans).to eq([])
	end

	it 'can update the status from ordered to paid' do
		order.update_status
		expect(order.status).to eq('paid')
	end

	it 'can cancel the status' do
		order.cancel
		expect(order.status).to eq('cancelled')
	end

	it 'can update the status from paid to completed' do
		order2 = Order.new(user_id: 2, order_type: "delivery", payment_type: 'cash', address_id: 4, status: "paid")
		order2.update_status
		expect(order2.status).to eq('completed')
	end

	it 'can have an loan removed' do
		loan = Loan.create!(title: 'Buy a cow',
														description: 'Need to buy a milking cow for our farm',
														amount: 50000,
														requested_by: "2014-09-10",
														repayments_begin: "2014-09-10",
														monthly_payment: 1000
														)
		order.loans << loan
		expect(order.loans).to eq([loan])

		order.remove_loan(1)
		expect(order.loans).to eq([])
	end

	it 'can calculate total wait time' do
		example = Order.create(user_id: 1, order_type: "delivery", payment_type: 'cash', address_id: 3, status: "paid")
		example2 = Order.create(user_id: 2, order_type: "pickup", payment_type: 'cash', address_id: 4, status: "ordered")

		time = example2.total_wait_time
		expect(16).to eq(time)
	end

	it 'can calculate current wait time' do
		example = Order.create(user_id: 1, order_type: "delivery", payment_type: 'cash', address_id: 3, status: "paid")
		example2 = Order.create(user_id: 2, order_type: "pickup", payment_type: 'cash', address_id: 4, status: "ordered")

		time = example2.current_wait_time
		expect('16 minutes until ready for pickup').to eq(time)
	end
end
