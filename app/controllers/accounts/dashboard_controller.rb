module Accounts
  class DashboardController < BaseController
    def show
      pagy, projects = pagy(all_projects)
      render inertia: "Accounts/AccountDashboard", props: {
        projects: projects.as_json(include: [:memberships]),
        pagination: pagy
      }
    end

    private

    def all_projects
      policy_scope(current_account.projects).includes(:memberships)
    end
  end
end
