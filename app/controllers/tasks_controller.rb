class TasksController < ApplicationController
  def create
    task = task_params.merge(user_id: current_user.id)
    task = Task.create!(task)
    render json: { id: task.id }
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes!(task_params)
    render_partial(task)
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

    def render_partial(task)
      if more_than_one_task?(task)
        render partial: "task", locals: { task: TaskDecorator.new(task) }
      else
        render partial: "task_list", locals: { tasks: [TaskDecorator.new(task)] }
      end
    end

    def more_than_one_task?(task)
      time = task.updated_at.localtime
      range = time.beginning_of_day..time.end_of_day
      task_times = Task.select(:updated_at).map { |t| t.updated_at.localtime }
      task_times.select { |t| range.cover?(t) }.size > 1 ? true : false
    end
end
