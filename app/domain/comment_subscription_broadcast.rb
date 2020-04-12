class CommentSubscriptionBroadcast < SubscriptionBroadcast
  def broadcast
    return unless event.action.to_s == "created"

    subscribers.each do |subscriber|
      Subscriptions::CommentCreatedNotifierJob.perform_later(comment.id, subscriber.user_id)
    end
  end

  private

  def subscribers
    @subscribers ||= comment.commentable.recording.subscribers
  end

  def comment
    @comment ||= @event.recordable
  end
end
