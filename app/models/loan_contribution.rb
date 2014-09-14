class LoanContribution < ActiveRecord::Base
  belongs_to :loan
  belongs_to :category
end
