require 'test_helper'

class EditMessageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: account, name: "Save the world")
    add_user_to_project(@user, @project)
    @message = create(:message, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{account.subdomain}.lvh.me"
    sign_in(@user)
    visit edit_bucket_message_path(@project.bucket, @message)
    assert_text "Edit #{@message.subject}"
  end

  test "updates successfully" do
    fill_in "message_subject", with: "Awesome"
    fill_in_rich_text_area "message_content", with: "Test"
    click_button("Save Changes")
    assert_text "Message updated."
    assert current_path == bucket_message_path(@project.bucket, @message)
    assert_text "Awesome"
    assert_text "Test"
  end

  test "handles errors" do
    fill_in "message_subject", with: ""
    fill_in_rich_text_area "message_content", with: ""
    click_button("Save Changes")
    assert_text "There were problems saving your changes."
    assert_text "can't be blank"
  end
end
