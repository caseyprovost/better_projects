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
        bucket_recording = build_bucket_recording(new_message)
        success = bucket_recording.save
        message = bucket_recording.model

        if success
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

      def build_bucket_recording(message)
        BucketRecording.new(message, {
          parent: @parent_recording,
          bucket: current_bucket,
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
