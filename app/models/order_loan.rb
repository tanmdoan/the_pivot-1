class OrderLoan < ActiveRecord::Base
	belongs_to :order
	belongs_to :loan
	validates_numericality_of :unit_price, greater_than_or_equal_to: 0
end
