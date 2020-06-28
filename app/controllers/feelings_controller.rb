class FeelingsController < ApplicationController
  before_action :set_feeling, only: [:show, :edit, :update, :destroy]

  def index
    @feelings = Feeling.all.order(:day)
  end

  def new
    @feeling = Feeling.new
  end

  def edit
  end

  def create
    @feeling = Feeling.new(feeling_params)

    respond_to do |format|
      if @feeling.save
        format.html { redirect_to feelings_url, notice: 'Feeling was successfully created.' }
        format.json { render action: 'show', status: :created, location: @feeling }
      else
        format.html { render action: 'new' }
        format.json { render json: @feeling.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feeling.update(feeling_params)
        format.html { redirect_to feelings_url, notice: 'Feeling was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feeling.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feeling.destroy
    respond_to do |format|
      format.html { redirect_to feelings_url }
      format.json { head :no_content }
    end
  end

  private
    def set_feeling
      @feeling = Feeling.find(params[:id])
    end

    def feeling_params
      params.require(:feeling).permit(:content, :day)
    end
end
