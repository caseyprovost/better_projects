require_relative "../system_test_helper"

class MessageBoardPageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    add_user_to_project(@user, @project)
    create_list(:message, 3, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit bucket_message_board_path(@project.bucket)
    assert_text "Message Board"
  end

  test "displays the messages" do
    message_boxes = all('[data-component="MessageBox"]')
    assert message_boxes.count == 3
  end

  test "allows new messages to be created" do
    find(:link, text: "New Message").click
    assert_text "Post a New Message"
  end
end
