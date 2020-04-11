module Buckets
  module Recordings
    class CommentsController < BaseController
      def create
        new_comment = recording.comments.new(comment_params)
        bucket_recording = build_bucket_recording(new_comment)
        success = bucket_recording.save
        comment = bucket_recording.model

        if success
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

      def build_bucket_recording(message)
        BucketRecording.new(message, {
          parent: @parent_recording,
          bucket: current_bucket,
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
