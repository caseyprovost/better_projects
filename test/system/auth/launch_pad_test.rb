require_relative "../system_test_helper"

class LaunchPadTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed)
    @account = create(:account, name: "avengers", owner: @user)
    @account2 = create(:account, owner: create(:user), name: "heroes")
    create(:account_member, :writer, account: @account2, user: @user)
    Capybara.app_host = "http://app.lvh.me"
  end

  test "presents multi-account users with a launch pad" do
    visit new_user_session_path
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: "google")
    click_button("Sign in")
    assert_text "Signed in successfully."
    assert_text "Accounts"

    click_link("account_#{@account2.id}")
    assert_text "Projects"
    assert current_url.include?("heroes.lvh.me")
  end
end
