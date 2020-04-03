module Buckets
  module Recordings
    class MovesController < BaseController
      def new
        move = build_recording_move

        render inertia: "Recordings/MoveRecording", props: {
          move: move.attributes,
          recording: recording.as_json(include: [:recordable], methods: [:title, :content]),
          buckets: buckets.as_json(only: %i[id], methods: %i[name])
        }
      end

      def create
        move = RecordingMove.new(move_params)

        if move.save
          copy = move.copy
          flash.notice = "Your message was moved to #{copy.bucket.name}"
          redirect_to polymorphic_url([copy.bucket, copy.recordable])
        else
          redirect_to new_bucket_recording_move_path(current_bucket, recording), errors: move.errors
        end
      end

      private

      def buckets
        policy_scope(current_account.buckets)
      end

      def build_recording_move
        RecordingMove.new(
          recording: recording,
          destination_bucket_id: current_bucket.id,
          user: current_user
        )
      end

      def move_params
        params.require(:move).permit(:destination_bucket_id).tap do |data|
          bucket = buckets.find_by(id: data[:destination_bucket_id])
          data[:destination_bucket_id] = bucket&.id
          data[:user] = current_user
          data[:recording] = recording
        end
      end
    end
  end
end
