require_relative "../system_test_helper"

class MoveMessagePageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    @project2 = create(:project, account: @account, name: "Order new costumes")
    @message = create(:message, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit new_project_message_move_path(@project, @message)
    assert_text "Move this message"
  end

  test "can move" do
    select @project2.name, from: "project_id"
    click_button("Move to this project")
    assert_text "Your message was moved"
    assert current_path == project_message_path(@project2, @project2.messages.last)
  end
end
