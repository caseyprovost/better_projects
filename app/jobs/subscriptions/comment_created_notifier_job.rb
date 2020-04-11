module Subscriptions
  class CommentCreatedNotifierJob < ApplicationJob
    def perform(comment_id, user_id)
      comment = Comment.find(comment_id)
      user = User.find(user_id)

      CommentMailer.new_comment_notification(comment, user).deliver_now!
    end
  end
end
