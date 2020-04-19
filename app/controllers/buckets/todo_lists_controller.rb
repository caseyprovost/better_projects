module Buckets
  class TodoListsController < BaseController
    inertia_share todo_set: -> { todo_list.todo_set }
    before_action :grab_todo_set, only: %i[show]
    before_action :set_parent_recording

    def show
      render inertia: "TodoLists/ViewTodoList", props: {
        todo_list: todo_list.as_json(include: [creator: {}, todos: {include: [:assignees, :subscribers]}]),
        assignees: possibleUsers,
        notifiees: possibleUsers
      }
    end

    def create
      @todo_set = current_bucket.todo_sets.find(todo_list_params[:todo_set_id])
      new_todo_list = @todo_set.todo_lists.new(todo_list_params.except(:todo_set_id))
      result = create_bucket_recording(new_todo_list)
      todo_list = result.model

      if todo_list.persisted?
        flash.notice = "Your list was successfully created"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, @todo_set))
      else
        flash.alert = "Oh no, we couldn't create your list!"
        redirect_to bucket_todo_set_path(current_bucket, todo_set), errors: todo_list.errors
      end
    end

    private

    def create_bucket_recording(model)
      current_bucket.record(model, {
        parent: @parent_recording
        # status: status_param,
        # subscribers: find_subscribers
      })
    end

    def set_parent_recording
      @parent_recording = nil
    end

    def todo_list_params
      params.require(:todo_list).permit(:title, :description, :todo_set_id).tap do |data|
        data[:creator] = current_user
      end
    end

    def possibleUsers
      @possibleUsers ||= current_bucket.bucketable.users.where.not(users: {id: current_user.id})
    end

    def todo_list
      @todo_list ||= current_bucket.todo_lists.find(params[:id])
    end

    def grab_todo_set
      @todo_set = todo_list.todo_set
    end
  end
end
