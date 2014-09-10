class CreateOrderLoans < ActiveRecord::Migration
  def change
    create_table :order_loans do |t|
      t.integer :loan_id
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end
