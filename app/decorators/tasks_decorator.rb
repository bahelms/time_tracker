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

    def user_tasks_for_week
      week = Time.current.localtime.beginning_of_week..Time.current.localtime
      Task.where(updated_at: week, user_id: current_user.id)
    end
end
