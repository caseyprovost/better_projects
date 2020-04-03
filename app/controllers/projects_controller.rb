class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def show
    authorize @project
    render inertia: "Projects/ViewProject", props: {
      project: @project.as_json(include: [:bucket]),
      messages: json_messages,
      todo_lists: json_todo_lists
    }
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
  end

  def new
    @project = @account.projects.new
    authorize @project

    render inertia: "Projects/NewProject", props: {
      project: @project
    }
  end

  def create
    @project = current_account.projects.new(project_params)
    authorize @project
    @project.memberships.build(user: current_user, permission: "admin")

    if @project.save
      redirect_to project_path(@project), notice: "Project created."
    else
      redirect_to account_dashboard_path(current_account), errors: @project.errors
    end
  end

  def destroy
    authorize @project

    if @project.destroy
      flash.notice = "Your project was incinerated!"
    else
      flash.error = "Oops! Looks like we could not incinerate your project"
    end

    redirect_back(fallback_location: projects_path)
  end

  private

  def current_bucket
    current_bucket ||= @project.bucket
  end

  def json_messages
    @project.messages.includes(:creator).limit(5)
      .as_json(include: [:creator], methods: [:content_preview])
  end

  def json_todo_lists
    TodoList
      .joins("INNER JOIN todos ON todos.parent_id = todo_lists.id")
      .joins("INNER JOIN todo_sets ON todo_lists.parent_id = todo_sets.id")
      .joins("INNER JOIN buckets ON todo_sets.bucket_id = buckets.id")
      .group("todo_lists.position, todos.position, todo_lists.id")
      .limit(5)
      .as_json(include: [:todos], methods: [:description_preview])
  end

  def set_project
    @project = policy_scope(current_account.projects).includes(:message_board).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
