require_relative "../system_test_helper"

class MessageBoardTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    create_list(:message, 3, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit project_message_board_path(@project)
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
