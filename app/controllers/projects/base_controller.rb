module Projects
  class BaseController < ApplicationController
    before_action :enforce_project_access!

    helper_method :current_project

    inertia_share current_project: -> { current_project }

    private

    def enforce_project_access!
      return if user_belongs_to_account? || user_belongs_to_project?
      return if current_project.project_memberships.find_by(user_id: current_user.id)

      raise ActiveRecord::RecordNotFound
    end

    def current_project
      @current_project ||= current_account.projects
        .includes(
          message_board: { messages: [:creator] },
        ).find(params[:project_id])
    end

    def user_belongs_to_account?
      current_account.account_memberships.find_by(user_id: current_user.id)
    end

    def user_belongs_to_project?
      current_project.project_memberships.find_by(user_id: current_user.id)
    end
  end
end
