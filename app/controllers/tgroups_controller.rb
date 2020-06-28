class TgroupsController < ApplicationController
  before_action :set_tgroup, only: [:show, :edit, :update, :destroy]

  def index
    @tgroups = Tgroup.all
  end

  def new
    @tgroup = Tgroup.new
  end

  def edit
  end

  def create
    @tgroup = Tgroup.new(tgroup_params)

    respond_to do |format|
      if @tgroup.save
        format.html { redirect_to tgroups_url, notice: 'Tgroup was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tgroup }
      else
        format.html { render action: 'new' }
        format.json { render json: @tgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tgroup.update(tgroup_params)
        format.html { redirect_to tgroups_url, notice: 'Tgroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tgroup.destroy
    respond_to do |format|
      format.html { redirect_to tgroups_url }
      format.json { head :no_content }
    end
  end

  private
    def set_tgroup
      @tgroup = Tgroup.find(params[:id])
    end

    def tgroup_params
      params.require(:tgroup).permit(:name, :negative, target_ids: [])
    end
end
