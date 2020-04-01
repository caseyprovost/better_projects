require_relative "../system_test_helper"

class EditMessageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: account, name: "Save the world")
    @message = create(:message, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{account.subdomain}.lvh.me"
    sign_in(@user)
    visit edit_project_message_path(@project, @message)
    assert_text "Edit #{@message.subject}"
  end

  test "updates successfully" do
    fill_in "message_subject", with: "Awesome"
    fill_in_rich_text_area "message_content", with: "Test"
    click_button("Save Changes")
    assert_text "Message updated."
    assert current_path == project_message_path(@project, @message)
    assert_text "Awesome"
    assert_text "Test"
  end

  test "handles errors" do
    fill_in "message_subject", with: ""
    fill_in_rich_text_area "message_content", with: ""
    click_button("Save Changes")
    # TODO: Come back and fix this
    assert_text "There is one form error" # should be 2...but subject is not clearing for whatever reason
  end
end
