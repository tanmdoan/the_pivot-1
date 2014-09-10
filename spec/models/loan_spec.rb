require 'rails_helper'

RSpec.describe Item, type: :model  do
	let(:loan) { Loan.create!(title: 'Buy a cow',
													description: 'Need to buy a milking cow for our farm',
													amount: 50000,
													requested_by: "2014-09-10 13:43:00 -0600",
													repayments_begin: "2014-09-10 13:43:00 -0600",
													monthly_payment: 1000
													) }

	it 'is valid' do
		expect(item).to be_valid
	end

	it { should validate_presence_of(:title) }

	it { should validate_presence_of(:description) }

	it { should validate_presence_of(:amount)}

	it {should validate_numericality_of(:amount)}

	it { should validate_presence_of(:requested_by)}

	it { should validate_presence_of(:repayments_begin)}

	it { should validate_presence_of(:monthly_payment)}

	it { should validate_numericality_of(:monthly_payment)}

	it 'has an array of categories' do
		expect(item.categories).to eq([])
	end
end
