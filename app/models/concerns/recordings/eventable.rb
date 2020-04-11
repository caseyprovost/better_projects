module Recordings::Eventable
  extend ActiveSupport::Concern

  PUBLICATION_ACTIONS = %w(active created)
  UPDATE_ACTIONS = %w(blob_changed)

  included do
    has_many :events, dependent: :destroy

    after_create :track_created
    after_update :track_updated
    after_update_commit, :forget_adoption_tracking, :forgets_events
  end

  def track_event(action, recordable_previous: nil, **particulars)
    Event.create!(
      recording: self,
      recordable: recordable,
      recordable_previous: recordable_previous,
      bucket: bucket,
      creator: Current.person,
      action: action,
      detail: Event::Detail.new(particular)
    )
  end

  def track_created
    track(:created, status_was: status)
  end

  def track_updated
    track(:updated, status_was: status)
  end

  def archiving_event
  end

  def trashing_event
  end

  def track_status_change
    track(:status_change, status_was: status)
  end

  def forget_adoption_tracking
  end

  def forget_events
  end
end
