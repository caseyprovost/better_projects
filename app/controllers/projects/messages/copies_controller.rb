module Projects
  module Messages
    class CopiesController < BaseController
      def new
        copy = MessageCopy.new(source_message: message, project_id: current_project.id)
        render inertia: "Messages/NewCopy", props: {
          copy: copy.attributes,
          message: message.as_json,
          projects: current_account.projects.as_json(only: %i[id name])
        }
      end

      def create
        message_copy = MessageCopy.new(copy_params)

        if message_copy.save
          new_message = message_copy.message
          flash.notice = "Your copy of #{new_message.subject} has been created."
          redirect_to project_message_path(message_copy.project, new_message)
        else
          redirect_to new_project_message_copy_path(current_project, new_message), errors: message_copy.errors
        end
      end

      private

      def copy_params
        params.require(:copy).permit(:project_id).tap do |data|
          project = current_account.projects.find_by(id: data[:project_id])
          data[:project] = project
          data[:project_id] = project&.id
          data[:user] = current_user
          data[:source_message] = message
        end
      end
    end
  end
end
