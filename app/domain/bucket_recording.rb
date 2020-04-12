class BucketRecording
  attr_reader :model
  attr_reader :specifics

  delegate :errors, to: :model

  def self.create(model, **specifics)
    record = new(model, **specifics)
    record.save
  end

  def initialize(model, **specifics)
    @model = model
    @specifics = specifics
  end

  def save
    success = false

    ApplicationRecord.transaction do
      if model.save
        recording = build_recording
        recording.subscriptions.build(action: "created") if model.subscribeable?
        recording.save!
        success = true
      else
        # do something maybe?
      end
    end

    success
  end

  private

  def not_creator_users

  end

  def build_recording
    recording = Recording.new(recordable: model)
    recording.assign_attributes(specifics)
    recording.title = model.title
    recording
  end
end
