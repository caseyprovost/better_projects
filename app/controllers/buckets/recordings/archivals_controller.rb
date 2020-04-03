module Buckets
  module Recordings
    class ArchivalsController < BaseController
      # Generic support for archiving recordable models

      def create
        if recording.archive(current_user)
          flash.notice = "You archived this a second ago."
          redirect_to polymorphic_url([current_bucket, recording.parent])
        else
          flash.alert = "We were unable to archive this record"
          redirect_back(fallback_location: polymorphic_url([current_bucket, recording.recordable]))
        end
      end
    end
  end
end
