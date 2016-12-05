class TasksController < ApplicationController

	before_action :set_task, only: [:show, :edit, :update, :destroy]

	def index
    v = params[:v] || 1

    case v
    when 1
      today = Date.today

      @tasks = Task.where('start_date between ? and ?',today,(today+1.day)).order(:start_date)
    else
		  @tasks = Task.order(:start_date)
    end
	end


  def edit

  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :user_id, :fixed, :start_date, :tasl, :priority_id)
    end

end
