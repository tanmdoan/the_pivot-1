class OrderLoan < ActiveRecord::Base
	belongs_to :order
	belongs_to :loan
end
