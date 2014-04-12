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
    hours = duration.to_i / 3600
    minutes = duration.to_i - hours * 60
    secs = duration.to_i - (minutes*60 + hours*3600)
    "#{hours}:#{minutes}:#{secs}"
  end

  private
    def set_name
      task.name.blank? ? "(unknown task)" : task.name
    end
end
