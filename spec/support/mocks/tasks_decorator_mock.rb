class TasksDecoratorMock
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def tasks
    tasks = []
    5.times { tasks << Task.new(task_params(Time.current)) }
    2.times { tasks << Task.new(task_params(2.weeks.ago)) }
    tasks
  end

  private
    def task_params(time)
      { user_id: user.id, duration: 10000, updated_at: time }
    end
end
