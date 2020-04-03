module Buckets
  module Recordings
    class CopiesController < BaseController
      def new
        copy = build_recording_copy

        render inertia: "Recordings/CopyRecording", props: {
          copy: copy.attributes,
          recording: recording.as_json(include: [:recordable], methods: [:title, :content]),
          buckets: buckets.as_json(only: %i[id], methods: %i[name])
        }
      end

      def create
        copier = RecordingCopy.new(copy_params)

        if copier.save
          copy = copier.copy
          flash.notice = "Your copy of #{copy.title} has been created."
          redirect_to polymorphic_url([copy.bucket, copy.recordable])
        else
          redirect_to new_bucket_recording_copy_path(current_bucket, recording), errors: copy.errors
        end
      end

      private

      def buckets
        policy_scope(current_account.buckets)
      end

      def build_recording_copy
        RecordingCopy.new(
          recording: recording,
          destination_bucket_id: current_bucket.id,
          user: current_user
        )
      end

      def copy_params
        params.require(:copy).permit(:destination_bucket_id).tap do |data|
          bucket = buckets.find_by(id: data[:destination_bucket_id])
          data[:destination_bucket_id] = bucket&.id
          data[:user] = current_user
          data[:recording] = recording
        end
      end
    end
  end
end
