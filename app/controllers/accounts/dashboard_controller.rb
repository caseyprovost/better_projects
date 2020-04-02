module Accounts
  class DashboardController < BaseController
    def show
      render inertia: "Accounts/AccountDashboard", props: {
        projects: projects.limit(100).as_json(include: [:memberships])
      }
    end

    private

    def projects
      policy_scope(current_account.projects)
        .includes(:memberships)
    end
  end
end
