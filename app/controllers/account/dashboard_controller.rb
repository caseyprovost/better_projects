class Account::DashboardController < ApplicationController
  def show
    set_current_account(current_user.accounts.first)
    render inertia: "Accounts/AccountDashboard", props: {
      projects: []
    }
  end
end
