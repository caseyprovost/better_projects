module Buckets
  class TodosController < BaseController
    inertia_share todo_set: -> { todo.todo_list.todo_set }
    inertia_share todo_list: -> { todo.todo_list }
    inertia_share current_user: -> { current_user }

    def show
      render inertia: "Todos/ViewTodo", props: {
        todo: todo.as_json(
          include: [
            creator: {},
            recording: {include: [:comments]},
            completed_subscribers: {include: [:user]},
            assignments: {include: [:assignee]}
          ]
        ),
        possibleUsers: current_account.users,
        events: todo.recording.events.as_json(include: [:creator], methods: ["text"]),
        comments: []
      }
    end

    def create
      todo_list = current_bucket.todo_lists.find(todo_params[:todo_list_id])
      new_todo = todo_list.todos.new(todo_params.except(:todo_list_id))
      result = create_bucket_recording(new_todo)
      todo = result.model

      if todo.persisted?
        flash.notice = "Your todo was successfully created"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, todo_list.todo_set))
      else
        flash.alert = "Oh no, we couldn't create your todo!"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, todo_list.todo_set), errors: new_todo.errors)
      end
    end

    def update
      todo = current_bucket.todos.find(params[:id])

      if todo.update(todo_params.except(:todo_list_id))
        flash.notice = "Your todo was successfully created"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, todo_list.todo_set))
      else
        flash.alert = "Oh no, we couldn't update your todo!"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, todo_list.todo_set), errors: todo.errors)
      end
    end

    private

    def create_bucket_recording(model)
      todo_list = TodoList.find(params[:todo_list_id])
      current_bucket.record(model, {
        parent: todo_list.recording
        # status: status_param,
        # subscribers: find_subscribers
      })
    end

    def todo_params
      params.require(:todo).permit(
        :title,
        :description,
        :todo_list_id,
        :starts_on,
        :due_on,
        assignee_ids: [],
        notifiee_ids: []
      ).tap do |data|
        data[:creator] = current_user
      end
    end

    def todo
      @todo ||= current_bucket.todos.find(params[:id])
    end
  end
end
