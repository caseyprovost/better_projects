module Buckets
  module Todos
    class BaseController < ApplicationController
      inertia_share current_bucket: -> { current_bucket.as_json(include: [:bucketable]) }

      def current_bucket
        @current_bucket ||= current_account.buckets.find(params[:bucket_id])
      end

      def todo
        @todo ||= current_bucket.todos.find(params[:todo_id])
      end
    end
  end
end
