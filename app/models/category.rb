class Category < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :loan_categories
	has_many :loans, through: :loan_categories

  # scope :with_loans, -> { all.eager_load(:loans).where('loans.enabled' => true) }
end
