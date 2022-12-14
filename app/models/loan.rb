class Loan < ApplicationRecord
  
    belongs_to :member

    validates :amount, presence: true
    validates :repayment_duration, presence: true
    validates :interest, presence: true
    validates :start_date, presence: true
    validates :contract_number, presence: true
    
    scope :ordered, -> { order(start_date: :asc) }
    
    def total_amount_with_interest(amount, interest)
      i = 1 + (interest/100)
      amount * i
    end    
    
    def loan_interest_amount(amount_with_interest, amount)
      amount_with_interest - amount
    end
    
    def monthly_repayment(duration, loan_amount)
      loan_amount.to_f.ceil / duration 
    end
    
    def final_repayment_amount(amount_with_interest, duration)
      amount_with_interest % duration
    end
    
    def final_repayment_date(start_date, duration)
      start_date + (duration + 1).months
    end
    
    def advance_start_date_by_a_month(start_date)
      start_date + 1.months
    end
    
end
