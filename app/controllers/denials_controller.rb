class DenialsController < ApplicationController
  before_action :set_denial, only: [:show, :edit, :update, :destroy]

  # GET /denials
  # GET /denials.json
  def index
    @denials = Denial.all
  end

  # GET /denials/1
  # GET /denials/1.json
  def show
  end

  # GET /denials/new
  def new
    @denial = Denial.new
  end

  # GET /denials/1/edit
  def edit
  end

  # POST /denials
  # POST /denials.json
  def create
    @denial = Denial.new(denial_params)

    respond_to do |format|
      if @denial.save
        format.html { redirect_to denials_url, notice: 'Denial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @denial }
      else
        format.html { render action: 'new' }
        format.json { render json: @denial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /denials/1
  # PATCH/PUT /denials/1.json
  def update
    respond_to do |format|
      if @denial.update(denial_params)
        format.html { redirect_to denials_url, notice: 'Denial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @denial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /denials/1
  # DELETE /denials/1.json
  def destroy
    @denial.destroy
    respond_to do |format|
      format.html { redirect_to denials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_denial
      @denial = Denial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def denial_params
      params.require(:denial).permit(:name, :start_date)
    end
end
