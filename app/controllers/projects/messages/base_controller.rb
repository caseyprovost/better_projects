module Projects
  module Messages
    class BaseController < Projects::BaseController
      def message
        @message ||= current_project.messages.find(params[:message_id])
      end
    end
  end
end
