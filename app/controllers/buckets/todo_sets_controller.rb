module Buckets
  class TodoSetsController < BaseController
    def show
      render inertia: "TodoSets/ViewTodoSet", props: {
        todo_set: todo_set.as_json(include: [creator: {}, todo_lists: {include: :todos}]),
        assignees: possibleUsers,
        notifiees: possibleUsers
      }
    end

    private

    def possibleUsers
      @possibleUsers ||= current_bucket.bucketable.users.where.not(users: {id: current_user.id})
    end

    def todo_set
      @todo_set ||= current_bucket.todo_sets.find(params[:id])
    end
  end
end
