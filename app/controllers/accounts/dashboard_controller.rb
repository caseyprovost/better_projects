module Accounts
  class DashboardController < BaseController
    def show
      render inertia: "Accounts/AccountDashboard", props: {
        projects: current_account.projects.as_json(include: [:memberships])
      }
    end
  end
end
