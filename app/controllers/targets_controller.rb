class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  include TargetsHelper
  
  def index
    current_time = Time.now
    @tgroups = Tgroup.all
    if params[:tgroup_id]
      @gr_id = params[:tgroup_id]      
    else
      @gr_id = "1"
    end

    current_period

    @targets = Target.left_joins([:sets_name, :count_name, :tgroup])            
                     .select("targets.*, 
                              tgroups.name as group_name, 
                              sets_names.name as sets_name,
                              count_names.name as count_name,
                              '' as cls")

    # @sets_names = 
    # .joins('LEFT JOIN tgroups ON tgroups.id = targets.group_id')

    # @checked = []
    # 31.times do |day|
    #   checked[day] = []
    #   @target.each do |target|
    #     checked[day]
    #   end
    # end
    @checked = TargetDay.where(month: @current_month, year: @current_year)
    @days = @current_period.end_of_month.day

  end

  def new
    @target = Target.new
    @target.user_id = current_user.id
  end

  def edit
  end

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

  def destroy
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url }
      format.json { head :no_content }
    end
  end

  private
    def set_target
      @target = Target.find(params[:id])
    end

    def target_params
      params.require(:target).permit(:name, :parent_id, :user_id, :group_id, :id, :tgroup_ids => [])
    end
end
