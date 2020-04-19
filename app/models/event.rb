class Event < ApplicationRecord
  include Recordable
  include Creator

  belongs_to :bucket
  belongs_to :recording
  belongs_to :recordable, polymorphic: true
  belongs_to :previous_recordable, polymorphic: true, optional: true

  validates :action, presence: true

  after_create :broadcast_subscriptions

  def detail
    @detail ||= Event::Detail.new(details.except(*excluded_details))
  end

  def broadcast_subscriptions
    return unless recordable.subscribeable?

    broadcaster = SubscriptionBroadcastFactory.for_event(self)
    broadcaster.broadcast
  end
end
