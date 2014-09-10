class AddLoanCategoriesTable < ActiveRecord::Migration
  def change
  	create_table :loan_categories do |t|
      t.integer :loan_id
      t.integer :category_id

      t.timestamps
    end
  end
end
