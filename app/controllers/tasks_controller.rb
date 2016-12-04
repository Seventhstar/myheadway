class TasksController < ApplicationController

	before_action :set_task, only: [:show, :edit, :update, :destroy]

	def index
		@tasks = Task.order(:start_date)
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
end
