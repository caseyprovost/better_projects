require "application_system_test_case"

module SystemTestHelper
  def add_user_to_account(user, account, role: "admin")
    account_role = AccountRole.find_by(slug: role)
    account_role ||= create(:account_role, name: role.titleize)
    create(:account_member, account: account, user: user, role: account_role)
  end
end
