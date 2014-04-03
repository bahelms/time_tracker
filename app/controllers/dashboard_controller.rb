class DashboardController < ApplicationController
  def show
    week = Time.current.beginning_of_week..Time.current
    @tasks_for_week = TaskDecorator.new(Task.where(updated_at: week))
    t = @tasks_for_week.grouped_by_day
    binding.pry
  end
end
