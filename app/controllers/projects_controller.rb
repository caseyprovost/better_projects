class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  inertia_share current_project: -> { policy_scope(Project).find(params[:id]) }

  def show
    render inertia: "Projects/ViewProject", props: {
      project: @project,
      messages: json_messages
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
    project.memberships.build(user: current_user, permission: "admin")

    if project.save
      redirect_to project_path(project), notice: "Project created."
    else
      redirect_to account_dashboard_path(current_account), errors: project.errors
    end
  end

  def destroy
  end

  private

  def json_messages
    @project.messages.includes(:creator).limit(10)
      .as_json(include: [:creator], methods: [:content_preview])
  end

  def set_project
    @project = policy_scope(Project).includes(:message_board).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
