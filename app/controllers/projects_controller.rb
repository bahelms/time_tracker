class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    Project.create!(project_params)
    render partial: "project"
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end
end
