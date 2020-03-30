require "test_helper"

class MessageMoveTest < ActiveSupport::TestCase
  test "requires a project_id" do
    mover = MessageMove.new
    refute mover.valid?
    assert_equal mover.errors[:project_id], ["can't be blank"]
  end

  test "can move a message between projects" do
    account = create(:account)
    project1 = create(:project, account: account)
    project2 = create(:project, account: account)
    message = create(:message, message_board: project1.message_board, content: "Testing")

    mover = MessageMove.new(resource: message, project_id: project2.id, project: project2)
    assert mover.save
    assert project1.messages.count.zero?
    assert project2.messages.count == 1
  end
end
