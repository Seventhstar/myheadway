class DenialsController < ApplicationController
  before_action :set_denial, only: [:show, :edit, :update, :destroy]

  def index
    @denials = Denial.all
  end

  def new
    @denial = Denial.new
  end

  def edit
  end

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

  def destroy
    @denial.destroy
    respond_to do |format|
      format.html { redirect_to denials_url }
      format.json { head :no_content }
    end
  end

  private
    def set_denial
      @denial = Denial.find(params[:id])
    end

    def denial_params
      params.require(:denial).permit(:name, :start_date)
    end
end
