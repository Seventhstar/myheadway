class TgroupsController < ApplicationController
  before_action :set_tgroup, only: [:show, :edit, :update, :destroy]

  # GET /tgroups
  # GET /tgroups.json
  def index
    @tgroups = Tgroup.all
  end

  # GET /tgroups/1
  # GET /tgroups/1.json
  def show
  end

  # GET /tgroups/new
  def new
    @tgroup = Tgroup.new
  end

  # GET /tgroups/1/edit
  def edit
  end

  # POST /tgroups
  # POST /tgroups.json
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

  # PATCH/PUT /tgroups/1
  # PATCH/PUT /tgroups/1.json
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

  # DELETE /tgroups/1
  # DELETE /tgroups/1.json
  def destroy
    @tgroup.destroy
    respond_to do |format|
      format.html { redirect_to tgroups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tgroup
      @tgroup = Tgroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tgroup_params
      params.require(:tgroup).permit(:name, :negative, target_ids: [])
    end
end
