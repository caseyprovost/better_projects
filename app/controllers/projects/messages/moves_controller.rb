module Projects
  module Messages
    class MovesController < BaseController
      def new
        move = MessageMove.new(resource: message, project_id: current_project.id)
        render inertia: "Messages/MoveMessage", props: {
          move: move.attributes,
          message: message.as_json,
          projects: current_account.projects.as_json(only: %i[id name])
        }
      end

      def create
        move = MessageMove.new(move_params)

        if move.save
          message = move.resource
          flash.notice = "Your copy of #{message.subject} has been created."
          redirect_to project_message_path(message.project, message)
        else
          redirect_to new_project_message_move_path(current_project, message), errors: message.errors
        end
      end

      private

      def move_params
        params.require(:move).permit(:project_id).tap do |data|
          project = current_account.projects.find_by(id: data[:project_id])
          data[:project] = project
          data[:project_id] = project&.id
          data[:user] = current_user
          data[:resource] = message
        end
      end
    end
  end
end
