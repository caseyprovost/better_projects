module Buckets
  module MessageBoards
    class MessagesController < BaseController
      def new
        render inertia: "Messages/NewMessage", props: {
          message: Message.new.as_json
        }
      end

      def create
        new_message = message_board.messages.new(message_params)

        if new_message.update(message_params)
          redirect_to bucket_message_path(current_bucket, new_message), notice: "Message posted."
        else
          redirect_to edit_bucket_message_path(current_bucket, new_message), errors: new_message.errors
        end
      end

      private

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
