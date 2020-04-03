module ProjectTestHelpers
  def create_project_for_account(account, **attributes)
    create(:project, attributes.merge(account: account))
  end

  def add_user_to_project(user, project)
    create(:project_membership, user: user, project: project)
  end
end
