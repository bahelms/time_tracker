class TasksController < ApplicationController
  before_action :find_task, only: [:update, :manual_update]

  def index
    @tasks = TasksDecorator.new(Task.where(user_id: current_user.id))
    @projects = Project.where(user_id: current_user.id)
  end

  def create
    task = Task.create!(task_params.merge(user_id: current_user.id))
    render json: { id: task.id }
  end

  def update
    @task.update_attributes!(task_params)
    render_all_tasks_for_week
  end

  def manual_update
    #TODO protect against start times being later than stop times
    #TODO consider tasks spanning multiple days
    @task.start_time = convert_time(params[:start_time])
    @task.stop_time  = convert_time(params[:stop_time])
    @task.save!
    render_all_tasks_for_week
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

    def find_task
      @task = Task.find(params[:id])
    end

    def more_than_one_task?(task)
      time = task.updated_at.localtime
      range = time.beginning_of_day..time.end_of_day
      task_times = Task.select(:updated_at).map { |t| t.updated_at.localtime }
      task_times.select { |t| range.cover?(t) }.size > 1 ? true : false
    end

    def render_all_tasks_for_week
      @tasks = TasksDecorator.new(Task.where(user_id: current_user.id))
      render partial: "all_tasks_for_week"
    end

    def convert_time(time_string)
      date = Time.at(@task.start_time.to_i)
      time, period = time_string.split
      TimeConverter.new(time, period, date).convert.to_i
    end
end
