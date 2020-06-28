class TargetDaysController < ApplicationController
  before_action :set_target_day, only: [:show, :edit, :update, :destroy]

  def index
    @target_days = TargetDay.all
  end

  def new
    @target_day = TargetDay.new
  end

  def edit
  end

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

  def destroy
    @target_day.destroy
    respond_to do |format|
      format.html { redirect_to target_days_url }
      format.json { head :no_content }
    end
  end

  private
    def set_target_day
      @target_day = TargetDay.find(params[:id])
    end

    def target_day_params
      params.require(:target_day).permit(:checked, :target_id, :day, :month, :year)
    end
end
