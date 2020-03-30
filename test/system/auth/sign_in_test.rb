require_relative "../system_test_helper"

class SignInTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @account = create(:account, name: "avengers")
    Capybara.app_host = "http://avengers.lvh.me"
  end

  test "can log users in" do
    user = create(:user, :confirmed)
    add_user_to_account(user, @account, role: "admin")
    visit new_user_session_path
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: "google")
    click_button("Sign in")
    assert_text "Signed in successfully."
  end

  test "rejects users who are not confirmed" do
    user = create(:user)
    add_user_to_account(user, @account, role: "admin")
    visit new_user_session_path
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: "google")
    click_button("Sign in")
    assert_text "You have to confirm your email address before continuing."
  end

  test "rejects users who are locked" do
    user = create(:user, :confirmed, :locked)
    add_user_to_account(user, @account, role: "admin")
    visit new_user_session_path
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: "google")
    click_button("Sign in")
    assert_text "Your account is locked."
  end

  test "rejects incorrect credentials" do
    user = create(:user, :confirmed, :locked)
    add_user_to_account(user, @account, role: "admin")
    visit new_user_session_path
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: "wrong password")
    click_button("Sign in")
    assert_text "Invalid email or password!"
  end
end
