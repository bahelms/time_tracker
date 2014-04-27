class TasksDecorator
  attr_reader :tasks

  def initialize(tasks)
    @tasks = decorate(tasks_for_week(tasks))
  end

  def grouped_by_day
    days = tasks.map { |task| task.updated_at.localtime.day }.uniq
    days.map do |day|
      tasks.select { |task| task.updated_at.localtime.day == day }
    end
  end

  private
    def decorate(tasks)
      tasks.map { |task| TaskDecorator.new(task) }
    end

    def tasks_for_week(tasks)
      week = Time.current.localtime.beginning_of_week..Time.current.localtime
      tasks.where(updated_at: week)
    end
end
