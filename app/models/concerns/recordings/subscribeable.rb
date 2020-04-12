module Recordings::Subscribeable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, dependent: :delete_all, autosave: true
    has_many :subscribers, through: :subscriptions

    after_create { subscribe(creator) if subscribeable? }
  end

  def subscribeable?
    recordable.subscribeable?
  end

  def subscribe(users, track: false)
    folks = Array.wrap(users)

    folks.each do |user|
      subscriptions.each do |subscription|
        subscription.subscribers.create!(user: user)
      end
    end
  end

  def unsubscribe(users, track: false)
    folks = Array.wrap(users)
    Subscriber.joins(:subscriptions).where(
      user_id: folks.map(&:id),
      subscriptions: { id: subscriptions.ids }
    ).destroy_all
  end

  def change_subscribers(added: [], removed: [], track: false, notify: false)
    subscribe(added)
    unsubscribe(removed).where(subscriptions: { id: subscriptions.ids }).destroy_all
  end

  def replace_subscribers(users)
    Subscriber.joins(:subscriptions).where(subscriptions: { id: subscriptions.ids })
    subscribe(added)
  end

  def subscribed_by?(user)
    Subscriber.joins(:subscriptions).where(
      user_id: user.id,
      subscriptions: { id: subscriptions.ids }
    ).exists?
  end
end
