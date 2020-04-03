module Buckets
  module Recordings
    class BaseController < Buckets::BaseController
      # inertia_share recording: -> { recording }

      def recording
        @recording ||= current_bucket.recordings.find(params[:recording_id])
      end
    end
  end
end
