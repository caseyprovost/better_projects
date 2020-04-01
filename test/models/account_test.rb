require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "can add the owner on create" do
    user = create(:user)
    account = build(:account)
    account.owner = user

    assert account.save
    assert account.account_memberships.find_by(user_id: user.id).present?
  end

  test "can set the subdomain given a name" do
    account = build(:account, name: "Foo Bar", subdomain: nil)
    account.valid?
    assert_equal account.subdomain, "foobar"
  end
end
