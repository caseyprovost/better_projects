module Recordings::Subscribeable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, dependent: :delete_all
    has_many :subscribers, through: :subscriptions

    after_create { subscribe(creator) if subscribeable? }
  end

  def subscribeable?
    recordable.subscribeable?
  end

  def subscribe(users, track: false)
    folks = Array.wrap(users)
    subscriptions.each do |subscription|
      users.each do |user|
        subscription.subscriber.create!(user: user)
      end
    end
  end

  def unsubscribe(users, track: false)
  end

  def change_subscribers(added: [], removed: [], track: false, notify: false)
  end

  def replace_subscribers(users)
  end

  def subscribed_by?(user)
  end
end
