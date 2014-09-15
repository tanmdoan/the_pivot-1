class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :amount
      t.integer :user_id
      t.integer :loan_id

      t.timestamps
    end
  end
end
