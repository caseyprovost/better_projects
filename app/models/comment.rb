class Comment < ApplicationRecord
  include Creator, Recordable

  belongs_to :commentable, polymorphic: true

  validates :content, presence: true

  has_rich_text :content

  after_create :emit_create_event
  after_create :notify_subscribers

  delegate :bucket, to: :commentable

  def content_preview
    content.to_plain_text
  end

  def created_subscribers
    commentable.recording.subscribers.joins(:subscription).where(subscriptions: { action: "comment.created" })
  end

  private

  def emit_create_event
    recording.track_event()
    commentable.events.build(
      action: "comment.created",
      creator: Current.user,
      details: { content: content_preview }
    )
  end

  def notify_subscribers
    created_subscribers.each do |subscriber|
      Subscriptions::CommentCreatedNotifierJob.perform_later(id, subscriber.user.id)
    end
  end
end
