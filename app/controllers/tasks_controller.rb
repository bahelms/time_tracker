class TasksController < ApplicationController
  def create
    task = task_params.merge(user_id: current_user.id)
    task = Task.create!(task)
    render json: { id: task.id }
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes!(task_params)
    render text: "success"
  end

  private
    def task_params
      params.require(:task).permit(
        :name,
        :project_id,
        :start_time,
        :stop_time,
        :duration
      )
    end
end