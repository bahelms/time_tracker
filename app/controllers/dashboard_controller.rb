class DashboardController < ApplicationController
  def show
    @tasks = TasksDecorator.new(user_tasks_for_week)
  end

  private
    def user_tasks_for_week
      week = Time.current.localtime.beginning_of_week..Time.current.localtime
      Task.where(updated_at: week, user_id: current_user.id)
    end
end
