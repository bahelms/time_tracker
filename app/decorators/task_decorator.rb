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
    hours =   digits(duration.to_i / 3600)
    minutes = digits(duration.to_i/60 - hours.to_i*60)
    secs =    digits(duration.to_i % 60)
    "#{hours}:#{minutes}:#{secs}"
  end

  private
    def set_name
      task.name.blank? ? "(unknown task)" : task.name
    end

    def digits(num)
      num < 10 ? "0#{num}" : num
    end
end
