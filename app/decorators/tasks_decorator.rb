class TasksDecorator
  attr_reader :tasks

  def initialize(tasks)
    @tasks = decorate(tasks)
  end

  def grouped_by_day
    days = tasks.map { |task| task.updated_at.day }.uniq
    days.map do |day|
      tasks.select { |task| task.updated_at.day == day }
    end
  end

  def get_date_for(tasks_by_day)
    date = tasks_by_day.first.updated_at
    date.today? ? "Today" : date.strftime("%a, %b %-d")
  end

  private
    def decorate(tasks)
      tasks.map { |task| TaskDecorator.new(task) }
    end
end
