require "test_helper"

class MessageCopyTest < ActiveSupport::TestCase
  test "requires a project_id" do
    copy = MessageCopy.new
    refute copy.valid?
    assert_equal copy.errors[:project_id], ["can't be blank"]
  end

  test "can copy a message between projects" do
    user = create(:user)
    account = create(:account)
    project1 = create(:project, account: account)
    project2 = create(:project, account: account)
    message = create(:message, message_board: project1.message_board, content: "Testing")

    copy = MessageCopy.new(source_message: message, project_id: project2.id, project: project2, user: user)
    assert copy.save
    new_message = project2.messages.first
    assert new_message.present?
    assert_equal new_message.creator_id, user.id
  end
end
