class TaskDecorator
  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def grouped_by_day
    days = tasks.map { |task| task.updated_at.day }.uniq
    days.map do |day|
      tasks.select { |task| task.updated_at.day == day }
    end
  end
end
