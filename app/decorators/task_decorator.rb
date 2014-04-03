class TaskDecorator
  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def grouped_by_day
    temp = []
    days = tasks.map { |task| task.updated_at.day }.uniq

    days.each_with_index do |day, index|
      temp[index] << tasks.select { |task| task.updated_at.day == day }
    end
  end
end
