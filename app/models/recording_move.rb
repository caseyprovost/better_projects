class RecordingMove
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :destination_bucket_id, :integer
  attribute :recording
  attribute :user

  attr_reader :copy

  validates :destination_bucket_id, presence: true

  # Moving a recording trashes the source recording, creates a copy, and
  # moves that copy into the destination bucket
  def save
    new_recordable = recording.recordable.amoeba_dup
      .yield_self { |recordable| assign_recordable_bucket(recordable) }

    PaperTrail.request(whodunnit: user.id) do
      new_recordable.creator = user
      result = new_recordable.save
      @copy = new_recordable&.recording
      # TODO: Recordables that are moved are cloned, but the sources are trashed
      recording.trash(user) if result
      result
    end
  end

  private

  # can return a Project, TodoList, Document, etc
  def destination
    Bucket.includes(:bucketable).find(destination_bucket_id).record
  end

  def assign_recordable_bucket(recordable)
    case recordable.class.to_s
    when "Message"
      recordable.message_board = destination.message_board
    end

    recordable
  end
end
