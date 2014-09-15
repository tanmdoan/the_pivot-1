class Order < ActiveRecord::Base
  before_validation :set_default_values
	validates :user_id, :order_type, :payment_type, presence: true

	has_many :order_loans
	has_many :loans, through: :order_loans
  belongs_to :user
  belongs_to :address
  accepts_nested_attributes_for :address, reject_if: :pickup_or_existing_address

  scope :user_and_oi, -> { includes([:user, :order_loans]) }
  scope :ordered, -> { user_and_oi.where(status: 'ordered') }
  scope :paid, -> { user_and_oi.where(status: 'paid') }
  scope :completed, -> { user_and_oi.where(status: 'completed') }
  scope :cancelled, -> { user_and_oi.where(status: 'cancelled') }
  scope :current_orders, ->(user) { includes(:order_loans).where(user: user) }

  def self.new_with_loans(params, cart)
    order = new(params)
    loans = Loan.where(id: cart.keys)
    cart.each do |loan, quantity|
      order.order_loans.new(loan_id: loan)
    end
    order
  end

  def set_default_values
    self.status ||= 'ordered'
  end

  def total
    @total ||= order_loans.inject(0) { |sum, order_loan| sum += (order_loan.amount) }
  end

	def update_status
    if ordered?
      update_attribute(:status, 'paid')
    else
      update_attribute(:status, 'completed')
    end
	end

	def cancel
    update_attribute(:status, 'cancelled')
	end

	def remove_loan(loan_id)
    update_attribute(:loans, reject_from_loans(loan_id))
	end

  def ordered?
    status == 'ordered'
  end

  def paid?
    status == 'paid'
  end

  def pending?
    ordered? || paid?
  end

	def delivery?
		order_type == 'delivery'
	end

  def pickup?
    !delivery?
  end

  def pickup_or_existing_address
    pickup? || address_id
  end

  def total_wait_time
    # each paid order causes 4 min delay
    num_paid = Order.paid.size
    # order is delayed by 10 minutes for each additional six loans
    order_size_delay = loans.count / 6
    # 12 mins is default wait time
    minutes = 12 + num_paid * 4 + order_size_delay * 10
  end

  def current_wait_time
    wait_time = total_wait_time - (Time.now - created_at) / 60
    if wait_time > 0
      "#{wait_time.round} minutes until ready for pickup"
    else
      "ready for pickup"
    end
  end

  def charge(token)
    if payment_type == 'credit'
      begin
        charge = Stripe::Charge.create!(
          :amount => 1000, # amount in cents, again
          :currency => "usd",
          :card => token,
          :description => user.email
        )
        update_attribute(:status, 'paid')
      rescue Stripe::CardError => e
        errors.add :base, "There was a problem with your credit card."
        false
      end
    end
    true
  end

  private

  def reject_from_loans(loan_id)
    loans.reject { |loan| loan.id == loan_id.to_i }
  end
end
