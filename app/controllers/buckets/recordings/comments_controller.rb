module Buckets
  module Recordings
    class CommentsController < BaseController
      def create
        new_comment = recording.comments.new(comment_params)
        result = create_bucket_recording(new_comment)
        comment = result.model

        if result.success?
          flash.notice = "Your comment was successfully created."
          redirect_to polymorphic_url([current_bucket, recording.parent])
        else
          flash.alert = "We were unable to create your comment"
          redirect_back(fallback_location: polymorphic_url([current_bucket, recording.recordable]))
        end
      end

      private

      def set_parent_recording
        @parent_recording = recording
      end

      def create_bucket_recording(message)
        current_bucket.record(message, {
          parent: @parent_recording,
          bucket: current_bucket,
          creator: current_user
          # status: status_param,
          # subscribers: find_subscribers
        })
      end

      def comment_params
        params.require(:comment).permit(:content).tap do |data|
          data[:current_user] = current_user
        end
      end
    end
  end
end
