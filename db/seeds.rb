require_relative './seed/borrower_seeds'
require_relative './seed/loan_seeds'
require_relative './seed/category_seeds'
require_relative './seed/contribution_seeds'

# CATEGORIES
@categories.each do |category|
  Category.create(category)
end

# USERS
@users.each do |user|
  User.create(user)
end

# LOANS
@loans.each do |loan|
  Loan.create(loan)
end

# CONTRIBUTIONS
# @contributions.each do |contribution|
#   Contribution.create(contribution)
# end
