require 'test_helper'

class CopyMessagePageTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world")
    @project2 = create(:project, account: @account, name: "Order new costumes")
    add_user_to_project(@user, @project)
    add_user_to_project(@user, @project2)

    Current.set(user: @user) do
      result = @project.bucket.record(build(:message, creator: @user, message_board: @project.message_board))
      @message = result.model
    end

    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit new_bucket_recording_copy_path(@project.bucket, @message.recording)
    assert_text "Copy this message"
  end

  test "can copy" do
    select @project2.name, from: "destination_bucket_id"
    click_button("Copy to this location")
    assert_text "Your copy of #{@message.recording.title} has been created."
    assert current_path == bucket_message_path(@project2.bucket, @project2.messages.last)
  end
end
