class ProjectsController < ApplicationController
  before_action :set_project, only: %i(show edit update destroy)

  def show
    render inertia: "Projects/ViewProject", props: {
      project: @project
    }
  end

  def edit
  end

  def update
  end

  def new
    render inertia: "Projects/NewProject", props: {
      project: Project.new
    }
  end

  def create
    project = current_account.projects.new(project_params)
    project.memberships.build(user: current_user, permission: 'admin')

    if project.save

      redirect_to account_dashboard_path(current_account), notice: 'Project created.'
    else
      redirect_to account_dashboard_path(current_account), errors: project.errors
    end
  end

  def destroy
  end

  private

  def set_project
    @project = policy_scope(Project).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
