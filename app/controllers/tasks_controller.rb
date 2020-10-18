class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @task = Task.new
    v = params[:v] || 1

    case v
    when 1
      today  = Date.today
      @tasks = Task.where('start_date between ? and ?', today, today + 7.days)
                   .order(:start_date)
    else
      # efwe
      @tasks = Task.order(:start_date)
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    respond_with(@task = Task.create(task_params))
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy!
    head :no_content
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :user_id,
                                   :fixed, :start_date, :tasl, :priority_id,
                                   :task_cat_id)
    end
end
