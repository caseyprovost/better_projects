module Buckets
  module Todos
    class CompletionController < BaseController
      def create
        if todo.completed?
          todo.mark_incomplete
          flash.notice = "The todo was marked incomplete"
        else
          todo.mark_complete
          flash.notice = "The todo was marked completed"
        end

        redirect_back(fallback_location: bucket_todo_list_path(current_bucket, todo.todo_list))
      end
    end
  end
end
