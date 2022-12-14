class LoansController < ApplicationController
  
  before_action   :set_member
  before_action   :set_loan, only: %i[ show edit update destroy]
  
  
  def new
    @loan = @member.loans.build
  end

  def create
    @loan = @member.loans.build(loan_params)
    temporary_add_values # Temporary update attributes so that validation (below) can pass

    if @loan.save
      
      # Calculating the loan
      loan_calculation
      
      #Updating the loan calculation
      @loan.update!(amount_with_interest: @awi, interest_amount: @ia, repayment_amount: @ra, final_payment_amount: @fpa, 
                    end_date: @ed)
                    
      respond_to do |format| 
        format.html { redirect_to member_path(@member), notice: "Pinjaman telah diwujudkan" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update  
    
      if @loan.update(loan_params)
        
        # Calculating the loan 
        loan_calculation
        
        #Updating the loan calculation
        @loan.update!(amount_with_interest: @awi, interest_amount: @ia, repayment_amount: @ra, final_payment_amount: @fpa, 
                      end_date: @ed)
        
        respond_to do |format|
          format.html { redirect_to member_url(@member), notice: "Pinjaman telah di ubah" }
        end 
      else
        format.html { render :edit, status: :unprocessable_entity }
      end 
  end

  def show
    @repayment_date = @loan.start_date + 1.months
    @loan_amount    = @loan.amount_with_interest - @loan.repayment_amount
    @period         = @loan.repayment_duration
    @payment        = @loan.repayment_amount
    
  end
  
  def destroy
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to member_url(@member), notice: "Loan was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_member
    @member = Member.find(params[:member_id])
  end
  
  def set_loan
    @loan = @member.loans.find(params[:id])
  end
  
  def loan_params
    params.require(:loan).permit(:start_date, :amount, :repayment_duration,
                             :contract_number, :interest)
  end
  
  # Temporary set values for attributes to allow for validation to check the forms
  def temporary_add_values
    @loan.amount_with_interest = 0
    @loan.interest_amount = 0
    @loan.repayment_amount = 0
    @loan.final_payment_amount = 0
    @loan.end_date = Time.now.to_date
  end
  
  def loan_calculation
    
    #Loan calculation methods
    @awi = @loan.total_amount_with_interest(@loan.amount, @loan.interest)
    @ia  = @loan.loan_interest_amount(@awi, @loan.amount)
    @ra  = @loan.monthly_repayment(@loan.repayment_duration, @awi)
    @fpa = @loan.final_repayment_amount(@awi, @loan.repayment_duration)
    @ed  = @loan.final_repayment_date(@loan.start_date, @loan.repayment_duration)
    
  end
end
