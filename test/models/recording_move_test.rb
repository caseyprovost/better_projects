require "test_helper"

class RecordingMoveTest < ActiveSupport::TestCase
  test "requires a project_id" do
    copy = RecordingMove.new
    refute copy.valid?
    assert_equal copy.errors[:destination_bucket_id], ["can't be blank"]
  end

  test "can copy a recording between buckets" do
    user = create(:user)
    other_user = create(:user)
    account = create(:account)
    project1 = create(:project, account: account)
    project2 = create(:project, account: account)
    message = nil

    PaperTrail.request(whodunnit: other_user.id) do
      message = create(:message, message_board: project1.message_board, content: "Testing", creator: other_user)
    end

    mover = RecordingMove.new(
      recording: message.recording,
      destination_bucket_id: project2.bucket.id,
      user: user
    )

    assert mover.save
    recording_copy = mover.copy

    assert recording_copy.persisted?
    assert_equal recording_copy.bucket.id, project2.bucket.id
    assert_equal recording_copy.title, message.title
    assert_equal 1, message.versions.count
    assert message.trashed?
    assert_equal 1, recording_copy.recordable.versions.count
    assert_equal user.id, recording_copy.recordable.versions.first.whodunnit.to_i
  end
end
