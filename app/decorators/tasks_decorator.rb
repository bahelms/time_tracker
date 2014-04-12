class TasksDecorator
  attr_reader :tasks

  def initialize(tasks)
    @tasks = decorate(tasks)
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
end
