class CreateLoansTable < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.date :requested_by
      t.date :repayments_begin
      t.integer :monthly_payment
      t.attachment :image
      t.string :aasm_state
      t.integer :user_id

      t.timestamps
    end
  end
end
