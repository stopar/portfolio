module LoansHelper
  
  def next_repayment(date, amount, payment)
    @repayment_date = date + 1.months
    @loan_amount    = amount - payment
  end 
  
  def final_zero_amount(final_payment, payment, loan_amount)
    loan_amount + payment - final_payment
  end
  
end
