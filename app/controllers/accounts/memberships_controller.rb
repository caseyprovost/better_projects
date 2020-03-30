module Accounts
  class MembershipsController < BaseController
    def index
      render inertia: "Accounts/MembershipList", props: {
        memberships: current_account.account_memberships.as_json(include: [:role, :user])
      }
    end
  end
end
