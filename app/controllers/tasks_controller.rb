class TasksController < ApplicationController
  def create
    task = task_params.merge(user_id: current_user.id)
    Task.create!(task)
    render text: "success"
  end

  private
    def task_params
      params.require(:task).permit(
        :name,
        :project_id,
        time: [:start_time, :stop_time, :duration]
      )
    end
end
