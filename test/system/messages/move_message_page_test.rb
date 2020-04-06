require 'test_helper'

class MoveMessagePageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    @project2 = create(:project, account: @account, name: "Order new costumes")
    add_user_to_project(@user, @project)
    add_user_to_project(@user, @project2)
    @message = create(:message, creator: @user, message_board: @project.message_board)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit new_bucket_recording_move_path(@project.bucket, @message.recording)
    assert_text "Move this message"
  end

  test "can move" do
    select @project2.bucket.name, from: "destination_bucket_id"
    click_button("Move to this location")
    assert_text "Your message was moved"
    assert current_path == bucket_message_path(@project2.bucket, @project2.messages.last)
  end
end
