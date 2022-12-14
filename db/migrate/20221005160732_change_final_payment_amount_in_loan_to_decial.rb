class ChangeFinalPaymentAmountInLoanToDecial < ActiveRecord::Migration[7.0]
  def change
    change_column :loans, :final_payment_amount, :decimal, precision: 8, scale: 2
  end
end
