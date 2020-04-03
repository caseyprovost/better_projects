module Buckets
  class MessagesController < BaseController
    inertia_share message_board: -> { message_board }
    inertia_share message: -> { message.as_json(include: [:recording]) }

    def show
      render inertia: "Messages/ViewMessage", props: {
        recording: recording,
        message: message.as_json(include: [:creator])
      }
    end

    def edit
      render inertia: "Messages/EditMessage", props: {
        recording: recording,
        message: message.as_json(include: [:creator])
      }
    end

    def update
      if message.update(message_params)
        flash.notice = "Your changes have been saved."
        redirect_to bucket_message_path(current_bucket, message), notice: "Message updated."
      else
        flash.alert = "There were problems saving your changes."
        redirect_to edit_bucket_message_path(current_bucket, message), errors: message.errors
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

    def message_board
      @message_board ||= current_bucket.bucketable.message_board
    end

    def message
      @message ||= message_board.messages.find(params[:id])
    end
  end
end
