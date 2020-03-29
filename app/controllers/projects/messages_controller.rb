module Projects
  class MessagesController < BaseController
    inertia_share message_board: -> { message_board }
    inertia_share message: -> { message }

    def index
      pagy, messages = pagy(message_board.messages)

      render inertia: "Messages/MessageList", props: {
        messages: messages.as_json(include: [:creator]),
        pagination: @pagy
      }
    end

    def show
      render inertia: "Messages/ViewMessage", props: {
        message: message.as_json(include: [:creator])
      }
    end

    def edit
      render inertia: "Messages/EditMessage", props: {
        message: message.as_json(include: [:creator])
      }
    end

    def update
      if message.update(message_params)
        redirect_to project_message_path(current_project, message), notice: "Message updated."
      else
        redirect_to edit_project_message_path(current_project, message), errors: message.errors
      end
    end

    def new
      render inertia: "Messages/NewMessage", props: {
        message: Message.new.as_json
      }
    end

    def create
      message = message_board.messages.new(message_params)

      if message.update(message_params)
        redirect_to project_message_path(current_project, message), notice: "Message posted."
      else
        redirect_to edit_project_message_path(current_project, message), errors: message.errors
      end
    end

    def destroy
      if message.destroy
        redirect_to project_messages_path(current_project), notice: "Message deleted."
      else
        redirect_to project_message_path(current_project, message), errors: message.errors
      end
    end

    private

    def message_params
      params.require(:message).permit(:subject, :content).tap do |data|
        data[:creator] = current_user
      end
    end

    def message_board
      @message_board ||= current_project.message_board
    end

    def message
      @message ||= message_board.messages.find(params[:id])
    end
  end
end
