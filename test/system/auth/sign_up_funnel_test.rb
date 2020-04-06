require "test_helper"

class SignUpFunnelTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    Capybara.app_host = "http://app.lvh.me"
    visit new_user_registration_path
  end

  test "can sign up users" do
    fill_in("user_name", with: "bob marley")
    fill_in("user_email", with: "test@example.com")
    fill_in("user_password", with: "google")
    fill_in("user_password_confirmation", with: "google")
    click_button("Sign Up!")
    assert_text "A message with a confirmation link has been sent"

    user = User.find_by(email: "test@example.com")
    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    assert_text "Your email address has been successfully confirmed"

    fill_in("user_email", with: "test@example.com")
    fill_in("user_password", with: "google")
    click_button("Sign in")
    assert_text "Let's Get It Started"

    fill_in("account_name", with: "marvel")
    fill_in("account_subdomain", with: "marvel")
    click_button("Create Account")

    assert_text "Your account was successfully created."
    assert current_path == root_path
    assert_text "Projects"
  end
end
