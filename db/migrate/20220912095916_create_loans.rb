class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.decimal :repayment_amount, precision: 8, scale: 2, null: false
      t.integer :repayment_duration, null: false
      t.integer :final_payment_amount, precision: 8, scale: 2, null: false
      t.string :contract_number, null: false
      t.decimal :interest, precision: 4, scale: 2, null: false
      t.decimal :interest_amount, precision: 8, scale: 2, null: false
      t.decimal :amount_with_interest, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
