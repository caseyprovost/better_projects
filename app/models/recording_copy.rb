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
    recordable = old_recordable.amoeba_dup
      .yield_self { |recordable| assign_recordable_bucket(recordable) }
    success = false

    PaperTrail.request(whodunnit: user.id) do
      recordable.creator = user
      result = destination_bucket.record(recordable, creator: user)
      @copy = result.model.recording
      success = @copy.present?
    end

    success
  end

  private

  def old_recordable
    recording.recordable
  end

  def destination_bucket
    @destination_bucket ||= Bucket.includes(:bucketable).find(destination_bucket_id)
  end

  # can return a Project, TodoList, Document, etc
  def destination
    destination_bucket.bucketable
  end

  def assign_recordable_bucket(recordable)
    case recordable.class.to_s
    when "Message"
      recordable.message_board = destination.message_board
    end

    recordable
  end
end
