admin_role = AccountRole.find_or_create_by(name: "Admin")
owner_role = AccountRole.find_or_create_by(name: "Owner")

admin_role.touch

def setup_project_user(project, email:)
  user = User.find_by(email: email)
  user ||= FactoryBot.create(:user, name: Faker::Name.name, email: email)

  if project.memberships.find_by(user_id: user.id).nil?
    FactoryBot.create(:project_membership, project: project, user: user)
  end
end

def setup_project(project)
  if project.message_board.nil?
    MessageBoard.create!(project: project)
  end
end

if Rails.env.development?
  account = Account.find_or_create_by(name: "avengers")
  user = User.find_or_initialize_by(name: "Bruce Banner", email: "hulk@avengers.net")
  user.update(password: "google")
  user.confirm && user.save!
  Current.user = user

  AccountMember.find_or_create_by(account_id: account.id, user_id: user.id, role_id: owner_role.id)

  project = Project.find_or_create_by(
    name: "Mark XXX Suits",
    description: "This is that project that marries the metal and technology of Wakanda with the nanotech of Mr. Stark!",
    account_id: account.id,
    creator: user
  )

  setup_project(project)

  setup_project_user(project, email: "reader@avengers.net")
  setup_project_user(project, email: "writer@avengers.net")
  setup_project_user(project, email: "admin@avengers.net")
  setup_project_user(project, email: user.email)
end

Current.user = nil
