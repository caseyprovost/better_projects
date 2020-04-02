class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # Users can only see projects they are members of.
    # Account owners are an exception and can add themselves to any project as part of a
    # "permission override" feature, not in the scope of this policy :)
    def resolve
      scope.where(id: user.projects)
    end
  end

  def show?
    user_is_project_member?
  end

  def update?
    user_is_project_member?
  end

  def create?
    user_is_account_member?
  end

  def destroy?
    user_is_account_owner?
  end

  private

  def user_is_account_owner?
    @user_is_account_owner ||= user.is_account_owner?(record.account)
  end

  def user_is_project_member?
    @user_is_project_member ||= user.project_memberships.find_by(project_id: record.id).present?
  end

  def user_is_account_member?
    @user_is_account_member ||= user.account_memberships.find_by(account_id: record.account_id).present?
  end
end
