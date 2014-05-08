class ReportsController < ApplicationController
  def index
    @presenter = ReportsPresenter.new(data_provider)
  end

  private
    def data_provider
      TasksDecorator.new(Task.where(user_id: current_user.id))
    end
end
