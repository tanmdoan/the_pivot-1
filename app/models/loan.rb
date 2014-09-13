class Loan < ActiveRecord::Base
	validates :title,
						:description,
						:amount,
						:requested_by,
						:repayments_begin,
						:monthly_payment,
						presence: true
	validates_numericality_of :amount,
	 													:monthly_payment,
														greater_than_or_equal_to: 0
	has_many :loan_categories
	has_many :categories, through: :loan_categories
	has_many :orders, through: :order_loans
	belongs_to :user

	has_attached_file :image, styles: {:small => "150x150>", :thumb => "100x100>"}, default_url: "/assets/images/happy-borrower.jpg"
	validates_attachment :image, content_type: {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}

	def remove_category(category_id)
    update_attribute(:categories, reject_from_categories(category_id))
	end

	def amount_in_dollars
		correct_decimal = amount / 100
		"$#{correct_decimal}"
	end

	def monthly_payment_in_dollars
		correct_decimal = monthly_payment / 100
		"$#{correct_decimal}"
	end

  private

  def reject_from_categories(category_id)
	  categories.reject { |category| category.id == category_id.to_i}
  end
end
