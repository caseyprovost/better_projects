module Buckets
  module Recordings
    class ArchivalsController < BaseController
      # Generic support for archiving recordable models

      def create
        if recording.archive
          flash.notice = "The #{topic} was archived."
          redirect_to polymorphic_url(current_bucket, recording.recordable)
        else
          flash.notice = "We were unable to archive the #{topic}"
          redirect_back(fallback_location: project_path(current_project))
        end
      end

      def destroy
        if recording.unarchive
          flash.notice = "Your #{topic} was unarchived"
          redirect_to polymorphic_url(current_bucket, recording.recordable)
        else
          flash.notice = "We were unable to archive the #{topic}"
          redirect_back(fallback_location: project_path(current_project))
        end
      end

      private

      def fallback_url_for(recordable)
        case recordable.type.to_s
        when "Message"
          redirect_to bucket_message_board_path(current_bucket)
        else
          raise "Don't know how to redirect here"
        end
      end

      def topic
        @topic ||= recording.recordable.humanize.downcase
      end

      def recording_params
        params.require(:recording).permit(:status)
      end
    end
  end
end
