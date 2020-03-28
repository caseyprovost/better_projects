class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:account).where(id: user.project_memberships).
        or(
          scope.joins(:account).where(accounts: { id: user.account_memberships })
        )
    end
  end
end
