class LoanDecorator < Draper::Decorator
  decorates_association :categories

  delegate_all

  def display_categories
    categories.map { |c| c.name }.join(', ')
  end

  def unit_price_dollars
    h.price_in_dollars(amount)
  end

	def unit_price_decimal
    h.price_in_decimal(object.amount)
	end
end
