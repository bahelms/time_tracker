class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    project = Project.create!(project_params)
    render partial: "project", locals: { project: project }
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end
end
