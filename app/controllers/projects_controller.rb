class ProjectsController < ApplicationController
  def index
  end

  def create
    Project.create!(project_params)
    render partial: ""
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end
end
