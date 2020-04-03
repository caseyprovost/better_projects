require_relative "../system_test_helper"

class MessagePageTest < ApplicationSystemTestCase
  include SystemTestHelper

  def open_message_actions
    find(".btn-circle-indigo").click
  end

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create_project_for_account(@account, name: "Save the world")
    @project2 = create_project_for_account(@account, name: "Order new costumes")
    add_user_to_project(@user, @project)
    add_user_to_project(@user, @project2)
    @message = create(:message, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit bucket_message_path(@project.bucket, @message)
    assert_text @message.subject
  end

  test "displays the message body" do
    assert_text @message.content_preview
  end

  test "allows the user to edit" do
    open_message_actions
    assert_text "Edit"
    click_link("Edit")
    assert_text "Edit #{@message.subject}"
  end

  test "allows the user to move the message to another project" do
    open_message_actions
    assert_text "Move"
    click_link("Move")
    assert_text "Move this message"
  end

  test "allows the user to copy the message to another project" do
    open_message_actions
    assert_text "Copy"
    click_link("Copy")
    assert_text "Copy this message"
  end

  test "allows the user to archive the message" do
    open_message_actions
    assert_text "Archive"
    click_link("Archive")
    assert_text "You archived this a second ago"
  end
end
