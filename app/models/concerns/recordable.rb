module Recordable
  extend ActiveSupport::Concern

  included do
    has_one :recording, as: :recordable, autosave: true

    before_create :generate_recording
    before_update :update_recording

    has_paper_trail

    default_scope { joins(:recording) }
    scope :active, -> { where.not(recordings: { status: ["archived", "trashed"] }) }
  end

  private

  def should_update_recording?
    raise NotImplementedYet
  end

  def generate_recording
    build_recording(
      recordable: self,
      parent: parent,
      bucket: bucket,
      title: title,
      status: "active"
    )
  end

  def update_recording
    return unless should_update_recording?
    recording.update(title: title, parent: parent)
  end
end
