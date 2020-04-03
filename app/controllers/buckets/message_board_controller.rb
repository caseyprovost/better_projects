module Buckets
  class MessageBoardController < BaseController
    def show
      pagy, messages = pagy(message_board.messages.active)
      render inertia: "Projects/MessageBoard", props: {
        messages: messages.as_json(include: [:creator], methods: [:content_preview]),
        pagination: pagy
      }
    end

    private

    def message_board
      @message_board ||= current_bucket.bucketable.message_board
    end
  end
end
