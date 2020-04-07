module Buckets
  class TodoListsController < BaseController
    before_action :grab_todo_set, only: %i[show]

    def show
      render inertia: "TodoSets/ViewTodoSet", props: {
        todo_set: @todo_set.as_json(include: [:creator, todo_lists: [:todos]])
      }
    end

    def create
      @todo_set = current_bucket.todo_sets.find(todo_list_params[:todo_set_id])
      todo_list = @todo_set.todo_lists.new(todo_list_params.except(:todo_set_id))

      if todo_list.save
        flash.notice = "Your list was successfully created"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, @todo_set))
      else
        flash.alert = "Oh no, we couldn't create your list!"
        redirect_to bucket_todo_set_path(current_bucket, todo_set), errors: todo_list.errors
      end
    end

    private

    def todo_list_params
      params.require(:todo_list).permit(:title, :description, :todo_set_id).tap do |data|
        data[:creator] = current_user
      end
    end

    def todo_list
      @todo_list ||= current_bucket.todo_lists.find(params[:id])
    end

    def grab_todo_set
      @todo_set = todo_list.todo_set
    end
  end
end