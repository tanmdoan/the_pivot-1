require_relative './seed/borrower_seeds'
require_relative './seed/loan_seeds'

# CATEGORIES
Category.create(id: 1, name: "Agriculture")
Category.create(id: 2, name: "Small Business")
Category.create(id: 3, name: "Education")
Category.create(id: 4, name: "Women Owned Businesses")
Category.create(id: 5, name: "Conflict Areas")
Category.create(id: 6, name: "Shelter")


#Moms Favs

# USERS
users.each do |user|
  User.create(user)
end

# LOANS
loans.each do |loan|
  Loan.create(loan)
end

#ORDERS
#rachel_order1 = Order.create(user: rachel, order_type: 'delivery', payment_type: 'cash', address: rachel_address1, status: "ordered")
#Order.create(user: rachel, order_type: 'delivery', payment_type: 'credit', address: rachel_address2, status: "ordered")
#Order.create(user: jeff, order_type: 'delivery', payment_type: 'credit', address: jeff_address1, status: "ordered")
#Order.create(user: jeff, order_type: 'delivery', payment_type: 'credit', address: jeff_address1, status: "ordered")
#Order.create(user: jeff, order_type: 'delivery', payment_type: 'cash', address: jeff_address1, status: "cancelled")
#Order.create(user: jorge, order_type: 'delivery', payment_type: 'cash', address: jorge_address, status: "cancelled")
#Order.create(user: jorge, order_type: 'delivery', payment_type: 'cash', address: jorge_address, status: "paid")
#Order.create(user: jorge, order_type: 'pickup', payment_type: 'cash', address: jorge_address, status: "completed")
#Order.create(user: jorge, order_type: 'pickup', payment_type: 'cash', address: jorge_address, status: "ordered")
#Order.create(user: jorge, order_type: 'pickup', payment_type: 'cash', address: jorge_address, status: "paid")
#
#
###ORDER ITEMS
###1
#rachel_order1.order_items.create(item_id: 1,
#  order_id: 1, quantity: 3, unit_price: 2400)
#OrderItem.create(item_id: 2,
#  order_id: 1, quantity: 4, unit_price: 2000)
#OrderItem.create(item_id: 3,
#  order_id: 1, quantity: 5, unit_price: 5000)
###2
#OrderItem.create(item_id: 4,
#  order_id: 2, quantity: 1, unit_price: 3000)
#OrderItem.create(item_id: 5,
#  order_id: 2, quantity: 15, unit_price: 2050)
#OrderItem.create(item_id: 6,
#  order_id: 2, quantity: 4, unit_price: 1000)
###3
#OrderItem.create(item_id: 6,
#  order_id: 3, quantity: 7, unit_price: 600)
#OrderItem.create(item_id: 10,
#  order_id: 3, quantity: 1, unit_price: 5000)
###4
#OrderItem.create(item_id: 1,
#  order_id: 4, quantity: 1, unit_price: 3770)
#OrderItem.create(item_id: 9,
#  order_id: 4, quantity: 1, unit_price: 1110)
###5
#OrderItem.create(item_id: 13,
#  order_id: 5, quantity: 1, unit_price: 8000)
###6
#OrderItem.create(item_id: 12,
#  order_id: 6, quantity: 6, unit_price: 1230)
#OrderItem.create(item_id: 11,
#  order_id: 6, quantity: 2, unit_price: 1110)
#OrderItem.create(item_id: 10,
#  order_id: 6, quantity: 2, unit_price: 8900)
###7
#OrderItem.create(item_id: 9,
#  order_id: 7, quantity: 2, unit_price: 4000)
###8
#OrderItem.create(item_id: 8,
#  order_id: 8, quantity: 20, unit_price: 8000)
###9
#OrderItem.create(item_id: 11,
#  order_id: 9, quantity: 1, unit_price: 4440)
#OrderItem.create(item_id: 12,
#  order_id: 10, quantity: 2, unit_price: 1230)
#OrderItem.create(item_id: 3,
#  order_id: 11, quantity: 3, unit_price: 5000)
#OrderItem.create(item_id: 10,
#  order_id: 13, quantity: 4, unit_price: 1100)
###10
#OrderItem.create(item_id: 2,
#  order_id: 12, quantity: 5, unit_price: 8000)
#OrderItem.create(item_id: 3,
#  order_id: 14, quantity: 6, unit_price: 1000)
