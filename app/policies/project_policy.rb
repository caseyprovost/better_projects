class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .where(id: user.projects)
        .or(scope.where(id: user_projects_through_accounts(scope, user)))
    end

    private

    def user_projects_through_accounts(scope, user)
      scope.joins(:account).where(accounts: { id: user.accounts }).pluck(:id)
    end
  end
end
