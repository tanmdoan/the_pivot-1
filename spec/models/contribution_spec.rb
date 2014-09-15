require 'rails_helper'

RSpec.describe Contribution, type: :model do
  let (:contribution) {Contribution.create!(amount: 2500)}

  it 'is valid' do
    expect(contribution).to be_valid
  end

  it { should validate_presence_of(:amount) }

  it { should validate_numericality_of(:amount) }




  # contributions mean that less money is needed to fulfill a loan
  # can only make a contribution if the amount is less than what is owed
  # cannot contribute more than requested for loan
  # can only contribute to loans with status request
end
