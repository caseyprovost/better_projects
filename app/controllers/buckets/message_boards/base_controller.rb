module Buckets
  module MessageBoards
    class BaseController < ApplicationController
      inertia_share message_board: -> { message_board }
      inertia_share current_bucket: -> { current_bucket.as_json(include: [:bucketable]) }

      def current_bucket
        @current_bucket ||= current_account.buckets.find(params[:bucket_id])
      end

      def message_board
        @message_board ||= current_bucket.bucketable.message_board
      end
    end
  end
end
