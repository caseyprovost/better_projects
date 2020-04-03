module Buckets
  class MessageBoardController < BaseController
    def show
      render inertia: "Projects/MessageBoard", props: {
        messages: message_board.messages.as_json(include: [:creator], methods: [:content_preview])
      }
    end

    private

    def message_board
      @message_board ||= current_bucket.bucketable.message_board
    end
  end
end
