class TaskDecorator
  attr_reader :task, :name
  delegate :id, :time, :start_time, :stop_time, :duration, :user_id,
           :created_at, :updated_at, to: :task

  def initialize(task)
    @task = task
    @name = set_name
  end

  def start_time_formatted
    Time.at(start_time.to_i).strftime("%l:%M:%S %p")
  end

  def stop_time_formatted
    Time.at(stop_time.to_i).strftime("%l:%M:%S %p")
  end

  def duration_formatted
    minutes = duration.to_i / 60
    hours = minutes / 60.0
  end

  private
    def set_name
      task.name.blank? ? "(unknown task)" : task.name
    end
end
