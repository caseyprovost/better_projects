class BucketRecording
  attr_reader :model
  attr_reader :specifics

  delegate :errors, to: :model

  class Result < OpenStruct
    attr_accessor :errors
    attr_accessor :success

    def success?
      !!success
    end
  end

  def self.create(bucket, model, **specifics)
    record = new(bucket, model, specifics)
    record.save
  end

  def initialize(bucket, model, **specifics)
    @model = model
    @specifics = specifics
    @bucket = bucket
  end

  def save
    success = false

    ApplicationRecord.transaction do
      if model.save
        recording = build_recording
        recording.subscriptions.build(action: "created") if model.subscribeable?
        recording.save!
        success = true
      end
    end

    Result.new(errors: model.errors, model: model, success: success)
  end

  private

  attr_reader :bucket

  def build_recording
    recording = Recording.new(recordable: model, bucket: bucket)
    recording.assign_attributes(specifics)
    recording.title = model.title
    recording
  end
end
