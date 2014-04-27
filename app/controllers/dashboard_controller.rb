class DashboardController < ApplicationController
  def show
    @tasks = TasksDecorator.new(Task.where(user_id: current_user.id))
  end
end
