module Buckets
  module Recordings
    class CommentsController < BaseController
      def create
        comment = recording.comments.new(comment_params)

        if comment.save(current_user)
          flash.notice = "Your comment was successfully created."
          redirect_to polymorphic_url([current_bucket, recording.parent])
        else
          flash.alert = "We were unable to create your comment"
          redirect_back(fallback_location: polymorphic_url([current_bucket, recording.recordable]))
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:content).tap do |data|
          data[:current_user] = current_user
        end
      end
    end
  end
end
