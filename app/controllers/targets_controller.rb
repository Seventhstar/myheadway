class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  # GET /targets
  # GET /targets.json
  def index
    current_time = Time.now
    #@current_period = current_period
    #days = @current_period.end_of_month.day

    @tgroups = Tgroup.all
    puts params[:tgroup_id]
    if params[:tgroup_id]
       @gr_id = params[:tgroup_id]      
    else
      #@targets = Target.where('parent_id is NULL')
       @gr_id = 1
    end

    if Tgroup.count > 0
     @targets = Tgroup.find(@gr_id).targets
    else
     @targets = Target.where('parent_id is NULL')
    end

  end

  # GET /targets/1
  # GET /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  # POST /targets.json
  def create
    @target = Target.new(target_params)

    respond_to do |format|
      if @target.save
        format.html { redirect_to targets_path, notice: 'Target was successfully created.' }
        format.json { render action: 'show', status: :created, location: @target }
      else
        format.html { render action: 'new' }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to targets_path, notice: 'Target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:name, :parent_id, :user_id, :group_id, :id, :tgroup_ids=>[])
    end
end
