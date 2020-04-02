require "test_helper"

class ProjectPolicyTest < PolicyAssertions::Test
  setup do
    @user = create(:user)
    @account = create(:account)
    @project = create(:project, account: @account)
  end

  ## Denials

  test "users who are not part of the account can do NOTHING!!!" do
    refute_permit create(:user), Project.new(account: @account), "create?", "update?", "show?", "destroy?"
  end

  test "regular account members cannot delete projects" do
    create(:account_member, user: @user, account: @account)
    refute_permit @user, @project, "destroy?"
  end

  test "account members do not by default get to do stuff to projects" do
    refute_permit @user, @project, "update?", "show?", "destroy?"
  end

  ## Allowances

  test "account members can create projects" do
    create(:account_member, user: @user, account: @account)
    assert_permit @user, Project.new(account: @account), "create?"
  end

  test "project members can see and edit projects" do
    create(:project_membership, user: @user, project: @project)
    assert_permit @user, @project, "update?", "show?"
  end

  test "account owners can delete" do
    create(:account_member, :owner, user: @user, account: @account)
    assert_permit @user, @project, "destroy?"
  end
end
