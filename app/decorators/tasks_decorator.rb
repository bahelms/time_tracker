class TasksDecorator
  attr_reader :tasks, :tasks_for_week, :tasks_for_month

  def initialize(tasks)
    @tasks = tasks
    @tasks_for_week = decorate(tasks_for(:week))
    @tasks_for_month = decorate(tasks_for(:month))
  end

  def grouped_by_day
    days = tasks_for_week.map { |task| task.created_at.localtime.day }.uniq
    days.map do |day|
      tasks_for_week.select { |task| task.created_at.localtime.day == day }
    end
  end

  private
    def decorate(tasks)
      tasks.map { |task| TaskDecorator.new(task) }
    end

    def tasks_for(time)
      range = Time.current.localtime.send("beginning_of_#{time}")..
        Time.current.localtime
      tasks.where(created_at: range)
    end
end
