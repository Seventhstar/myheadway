class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]

  def index
    @claims = Claim.all
  end

  def new
    @claim = Claim.new
  end

  def edit
  end

  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        format.html { redirect_to claims_url, notice: 'Claim was successfully created.' }
        format.json { render action: 'show', status: :created, location: @claim }
      else
        format.html { render action: 'new' }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @claim.update(claim_params)
        format.html { redirect_to claims_url, notice: 'Claim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @claim.destroy
    respond_to do |format|
      format.html { redirect_to claims_url }
      format.json { head :no_content }
    end
  end

  private
    def set_claim
      @claim = Claim.find(params[:id])
    end

    def claim_params
      params.require(:claim).permit(:name, :date, :user_id, :reached)
    end
end
