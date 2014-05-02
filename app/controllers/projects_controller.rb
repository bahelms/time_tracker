class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
  end

  def create
    project = Project.create!(project_params.merge(user_id: current_user.id))
    render partial: "project", locals: { project: project }
  end

  def destroy
    Project.find(params[:id]).destroy
    render text: "Success"
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end
end
