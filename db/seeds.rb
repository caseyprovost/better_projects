admin_role = AccountRole.find_or_create_by(name: "Admin")

def setup_project_user(project, email:, permission:)
  user = User.find_by(email: email)
  user ||= FactoryBot.create(:user, name: Faker::Name.name, email: email)

  if project.memberships.find_by(user_id: user.id).nil?
    FactoryBot.create(:project_membership, project: project, user: user, permission: permission)
  end
end

def setup_project(project)
  if project.message_board.nil?
    MessageBoard.create!(project: project)
  end
end

if Rails.env.development?
  account = Account.find_or_create_by(name: "avengers")
  user = User.find_or_create_by(name: "Bruce Banner", email: "hulk@avengers.net")
  user.confirm && user.save!

  AccountMember.find_or_create_by(account_id: account.id, user_id: user.id, role_id: admin_role.id)

  project = Project.find_or_create_by(
    name: "Mark XXX Suits",
    description: "This is that project that marries the metal and technology of Wakanda with the nanotech of Mr. Stark!",
    account_id: account.id
  )

  setup_project(project)

  setup_project_user(project, email: "reader@avengers.net", permission: "read")
  setup_project_user(project, email: "writer@avengers.net", permission: "write")
  setup_project_user(project, email: "admin@avengers.net", permission: "admin")
end
