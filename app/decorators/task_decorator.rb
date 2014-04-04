class TaskDecorator
  attr_reader :task
  delegate :id, :name, :time, :start_time, :stop_time, :duration, :user_id,
           :created_at, :updated_at, to: :task

  def initialize(task)
    @task = task
  end

  def start_time_formatted
    Time.at(start_time.to_i)
  end

  def stop_time_formatted
    Time.at(stop_time.to_i)
  end

  def duration_formatted
  end
end
