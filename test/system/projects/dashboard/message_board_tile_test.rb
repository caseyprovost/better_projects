require "test_helper"

class MessageBoardTileTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    add_user_to_project(@user, @project)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit project_path(@project)
    assert_text "Message Board"
  end

  test "diplays the empty state" do
    assert_text "Post accouncements, pitch ideas, progress updates, etc. Keep feedback on topic."
  end

  test "goes to the new message view when there are no messages" do
    find(:link, text: "Message Board").click
    assert_text "Post a New Message"
  end

  test "displays message previews when messages exist" do
    Current.set(user: @user) do
      @project.bucket.record(build(:message, message_board: @project.message_board, subject: "Testing", content: "battle!"))
    end

    visit project_path(@project)

    assert_text "BB"
    assert_text "Testing"
    assert_text "battle!"
  end

  test "goes to the message board, when there are messages" do
    Current.set(user: @user) do
      @project.bucket.record(build(:message, message_board: @project.message_board, subject: "Testing", content: "battle!"))
    end

    visit project_path(@project)

    find(:link, text: "Message Board").click
    assert_text "Message Board"
    assert_text "Testing"
    assert_text "battle!"
  end
end
