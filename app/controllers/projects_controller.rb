class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    project = Project.create!(project_params.merge(user_id: current_user.id))
    render partial: "project", locals: { project: project }
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end
end
