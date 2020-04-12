module Buckets
  module MessageBoards
    class MessagesController < BaseController
      before_action :set_parent_recording, only: %i(new create)

      def new
        render inertia: "Messages/NewMessage", props: {
          message: Message.new.as_json
        }
      end

      def create
        new_message = message_board.messages.new(message_params)
        result = create_bucket_recording(new_message)
        message = result.model

        if result.success?
          flash.notice = "Message posted"
          redirect_to bucket_message_path(current_bucket, message)
        else
          redirect_to new_bucket_message_board_message_path(current_bucket, message_board), errors: bucket_recording.errors
        end
      end

      private

      def set_parent_recording
        @parent_recording = nil
      end

      def create_bucket_recording(message)
        current_bucket.record(message, {
          parent: @parent_recording,
          # status: status_param,
          # subscribers: find_subscribers
        })
      end

      def message_params
        params.require(:message).permit(:subject, :content).tap do |data|
          data[:creator] = current_user
        end
      end

      def recording
        @recording ||= message.recording
      end

      def message
        @message ||= message_board.messages.find(params[:id])
      end
    end
  end
end
