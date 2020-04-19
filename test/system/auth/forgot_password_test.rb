require "test_helper"

class ForgotPasswordTest < ApplicationSystemTestCase
  include SystemTestHelper
  include ActionMailer::TestHelper

  setup do
    @user = create(:user, :confirmed)
    account = create(:account, name: "avengers", owner: @user)
    Capybara.app_host = "http://app.lvh.me"
    ActionMailer::Base.deliveries.clear
  end

  teardown { ActionMailer::Base.deliveries.clear }

  test "users can receive a password reset email" do
    visit new_user_password_path
    fill_in("user_email", with: @user.email)
    click_button("Reset Password")

    assert_text "You will receive an email with instructions"
    email = ActionMailer::Base.deliveries.first
    assert email.present?
    assert_equal email.recipients, [@user.email]
    assert email.subject.include?("Reset password instructions")
  end

  test "emails that don't exist receive an error message" do
    visit new_user_password_path
    fill_in("user_email", with: "foobar@fake.net")
    click_button("Reset Password")
    assert_text "Sorry, we didn’t recognize that email address. Want to try another?"
  end

  test "rejects users who are locked" do
    @user.lock_access!
    visit new_user_password_path
    fill_in("user_email", with: @user.email)
    click_button("Reset Password")
    assert_text "Your account is locked."
  end

  test "rejects users who are are not confirmed" do
    @user.update(confirmed_at: nil)
    visit new_user_password_path
    fill_in("user_email", with: @user.email)
    click_button("Reset Password")
    assert_text "You must confirm your account before you reset your password"
  end
end
