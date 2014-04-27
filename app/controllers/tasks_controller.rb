class TasksController < ApplicationController
  def create
    task = task_params.merge(user_id: current_user.id)
    task = Task.create!(task)
    render json: { id: task.id }
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes!(task_params)
    @tasks = TasksDecorator.new(Task.where(user_id: current_user.id))
    render partial: "all_tasks_for_week"
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

    def more_than_one_task?(task)
      time = task.updated_at.localtime
      range = time.beginning_of_day..time.end_of_day
      task_times = Task.select(:updated_at).map { |t| t.updated_at.localtime }
      task_times.select { |t| range.cover?(t) }.size > 1 ? true : false
    end
end
