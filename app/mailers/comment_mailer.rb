class CommentMailer < ApplicationMailer
  def new_comment_notification(comment, user)
    topic = comment.commentable.title
    mail(to: user.email, subject: "Re: #{topic}")
  end
end
