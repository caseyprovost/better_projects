class ProjectsController < ApplicationController
  inertia_share current_bucket: -> { current_bucket.as_json(include: :todo_sets) }

  def show
    authorize project
    render inertia: "Projects/ViewProject", props: {
      project: project.as_json(include: [bucket: {}, memberships: {include: [:user]}]),
      messages: json_messages,
      todoLists: json_todo_lists
    }
  end

  def edit
    authorize project
  end

  def update
    authorize project
  end

  def new
    new_project = @account.projects.new
    authorize new_project

    render inertia: "Projects/NewProject", props: {
      project: new_project
    }
  end

  def create
    new_project = current_account.projects.new(project_params)
    authorize new_project
    new_project.memberships.build(user: current_user)

    if new_project.save
      redirect_to project_path(new_project), notice: "Project created."
    else
      redirect_to account_dashboard_path(current_account), errors: new_project.errors
    end
  end

  def destroy
    authorize project

    if project.destroy
      flash.notice = "Your project was incinerated!"
    else
      flash.error = "Oops! Looks like we could not incinerate your project"
    end

    redirect_back(fallback_location: projects_path)
  end

  private

  def current_bucket
    @current_bucket ||= project.present? ? project.bucket : nil
  end

  def json_messages
    project.messages.includes(:creator).limit(5)
      .as_json(include: [:creator], methods: [:content_preview])
  end

  def json_todo_lists
    current_bucket.todo_lists
      .includes(:todo_set, :todos)
      .order("todo_lists.position ASC")
      .limit(5)
      .as_json(include: [:todos], methods: [:description_preview])
  end

  def project
    @project ||= policy_scope(current_account.projects).includes(:message_board).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description).tap do |data|
      data[:creator] = current_user
    end
  end
end
