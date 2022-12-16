class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    @members = Member.all.ordered
  end

  # GET /members/1 or /members/1.json
  def show
    @loans = @member.loans.ordered
    # @loan  = @member.loans.new
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    @member = Member.find_by(id: params[:id])
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
  
    if @member.save
      
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update

      if @member.update(member_params)
        redirect_to members_path, notice: "Member was successfully updated." 
      else
        render :edit, status: :unprocessable_entity 

      end

  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    
    redirect_to members_path, alert: "Member was successfully destroyed." 
   
    # respond_to do |format|
    #   format.html { redirect_to members_path, notice: "Member was successfully destroyed." }
    # end
  end
  
  def upload
  end
  
  def import
    if params[:file].nil?
      redirect_to members_path
    else
      counter = Member.import_return_count(params[:file])
      flash.now[:notice] =  "#{counter} members added"
      @members = Member.all.ordered

      # respond_to do |format|
      #   format.turbo_stream { flash.now[:notice] = "#{@counter} members added"}
      # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :ic_number, :number)
    end
end
