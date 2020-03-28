module Projects
  class MembershipsController < BaseController
    def index
      render inertia: "Projects/Memberships", props: {
        project_memberships: current_project.project_memberships.as_json(include: [:user])
      }
    end

    def edit
      membership = current_project.project_memberships.find(params[:id])

      render inertia: "Projects/EditMembership", props: {
        project_membership: membership.as_json(include: [:user])
      }
    end

    def update
    end

    def new
      render inertia: "Projects/NewMembership", props: {
        project_membership: ProjectMembership.new(project_id: current_project.id)
      }
    end

    def create
      membership = current_project.project_memberships.new(project_membership_params)

      if membership.save
        flash.notice = "#{membership.user.name} was removed from this project"
        redirect_back(fallback_url: project_memberships_path(current_project))
      else
        render inertia: "Projects/NewMembership", props: {
          resource_errors: resource.errors,
          project_membership: ProjectMembership.new(project_id: current_project.id)
        }
      end
    end

    def destroy
      membership = current_project.project_memberships.includes(:user).find(params[:id])

      if membership.destroy
        flash.notice = "#{membership.user.name} was removed from this project"
      else
        flash.alert = "#{membership.user.name} could not be removed."
      end

      redirect_back(fallback_url: project_memberships_path(current_project))
    end
  end
end
