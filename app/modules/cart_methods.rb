module CartMethods
  def new_loans
    @new_loans ||= []
  end

  def empty?
    cart.empty?
  end

  def count
    cart.inject(0) { |sum, (_, x)| sum + x }
  end

  def total
    cart.inject(0) do |sum, (id, quantity)|
      loan = Loan.find(id)
      sum += loan.amount * quantity
    end
  end

  def store(loan_id, amount)
    loan_id = loan_id.to_s

    new_loans << loan_id unless exists?(loan_id)
    cart.store(loan_id, quantity(loan_id) + amount)

    if quantity(loan_id) <= 0
      delete(loan_id)
    end
  end

  def quantity(loan_id)
    cart.fetch(loan_id.to_s, 0)
  end

  def delete(loan_id)
    cart.delete(loan_id.to_s)
  end

  def new?(loan_id)
    new_loans.any? { |x| x == loan_id.to_s }
  end

  def exists?(item_id)
    cart.has_key?(item_id.to_s)
  end

  def keys
    cart.keys
  end

  def each
    if block_given?
      cart.each { |x| yield(x) }
    end
  end
end
