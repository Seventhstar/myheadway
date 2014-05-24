class TargetDaysController < ApplicationController
  before_action :set_target_day, only: [:show, :edit, :update, :destroy]

  # GET /target_days
  # GET /target_days.json
  def index
    @target_days = TargetDay.all
  end

  # GET /target_days/1
  # GET /target_days/1.json
  def show
  end

  # GET /target_days/new
  def new
    @target_day = TargetDay.new
  end

  # GET /target_days/1/edit
  def edit
  end

  # POST /target_days
  # POST /target_days.json
  def create
    @target_day = TargetDay.new(target_day_params)

    respond_to do |format|
      if @target_day.save
        format.html { redirect_to @target_day, notice: 'Target day was successfully created.' }
        format.json { render action: 'show', status: :created, location: @target_day }
      else
        format.html { render action: 'new' }
        format.json { render json: @target_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /target_days/1
  # PATCH/PUT /target_days/1.json
  def update
    respond_to do |format|
      if @target_day.update(target_day_params)
        format.html { redirect_to @target_day, notice: 'Target day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @target_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_days/1
  # DELETE /target_days/1.json
  def destroy
    @target_day.destroy
    respond_to do |format|
      format.html { redirect_to target_days_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target_day
      @target_day = TargetDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_day_params
      params.require(:target_day).permit(:checked, :target_id, :day, :month, :year)
    end
end
