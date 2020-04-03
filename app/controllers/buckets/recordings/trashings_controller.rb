module Buckets
  module Recordings
    class TrashingsController < BaseController
      # Generic support for archiving recordable models

      def create
        if recording.trash(current_user)
          flash.notice = "The item has been put in the trash."
          redirect_to polymorphic_url([current_bucket, recording.parent])
        else
          flash.alert = "We were unable to archive this record"
          redirect_back(fallback_location: polymorphic_url([current_bucket, recording.recordable]))
        end
      end
    end
  end
end
