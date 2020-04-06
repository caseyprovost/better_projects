module Buckets
  class TodosController < BaseController
    def create
      todo_list = current_bucket.todo_lists.find(todo_params[:todo_list_id])
      todo = todo_list.todos.new(todo_params.except(:todo_list_id))

      if todo.save
        flash.notice = "Your todo was successfully created"
        redirect_back(fallback_location: bucket_todo_set_path(current_bucket, todo_list.todo_set))
      else
        flash.alert = "Oh no, we couldn't create your todo!"
        redirect_to bucket_todo_set_path(current_bucket, todo_list.todo_set), errors: todo.errors
      end
    end

    private

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
