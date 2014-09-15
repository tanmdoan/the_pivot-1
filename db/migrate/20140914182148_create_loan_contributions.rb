class CreateLoanContributions < ActiveRecord::Migration
  def change
    create_table :loan_contributions do |t|
      t.integer :loan_id
      t.integer :contribution_id

      t.timestamps
    end
  end
end
