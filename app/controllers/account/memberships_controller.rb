class Account::MembershipsController < ApplicationController
  def index
    set_current_account(current_user.accounts.first)
    render inertia: "Accounts/MembershipList", props: {
      memberships: current_account.account_memberships.as_json(include: [:role, :user])
    }
  end
end
