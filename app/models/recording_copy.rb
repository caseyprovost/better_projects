class RecordingCopy
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :destination_bucket_id, :integer
  attribute :recording
  attribute :user

  attr_reader :copy

  validates :destination_bucket_id, presence: true

  # Copying a record preserves the original state of the source recording
  # The new recording is a "share" or "re-post".
  def save
    new_recordable = recording.recordable.amoeba_dup
      .yield_self { |recordable| assign_recordable_bucket(recordable) }

    PaperTrail.request(whodunnit: user.id) do
      new_recordable.creator = user
      result = new_recordable.save
      @copy = new_recordable&.recording
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
