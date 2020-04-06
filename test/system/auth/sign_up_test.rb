require "test_helper"

class SignUpTest < ApplicationSystemTestCase
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
  end

  test "handles validation errors" do
    click_button("Sign Up!")
    assert_text "can't be blank"
  end
end
