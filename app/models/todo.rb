class Todo < ApplicationRecord
  include Assignable
  include HasPosition
  include HasRecordingStatus
  include Recordable

  include Commentable # depends on Recordable
  include Eventable # depends on Recordable

  # To-dos are due soon if they are due tomorrow
  DUE_SOON_DAYS = 1

  belongs_to :todo_list, counter_cache: true
  belongs_to :creator, class_name: "User", default: -> { User.current }

  # Over-riding subscriptions to not include completed todo subscriptions
  # and subscribers
  has_many :subscriptions, -> { where.not(action: "completed") }, through: :recording
  has_many :subscribers, through: :subscriptions

  has_one :completed_subscription,
    -> { where(subscriptions: {action: "completed"}) },
    class_name: "Subscription",
    through: :recording,
    source: :subscriptions

  has_many :completed_subscribers, class_name: "Subscriber", through: :completed_subscription, source: :subscribers

  # before_update :emit_events
  # after_save :update_completed_subscribers

  validates :title, presence: true

  has_rich_text :description

  delegate :bucket, to: :parent

  scope :due_soon, -> {
    date = DateTime.today.advance(days: DUE_SOON_DAYS)
    where.not(due_on: nil).where(due_on: date.beginning_of_day..date.end_of_day)
  }

  def description_preview
    description.to_plain_text
  end

  def subscribeable?
    true
  end

  def parent
    todo_list
  end

  def mark_complete
    self.completed = true
    save
  end

  def mark_incomplete
    self.completed = false
    save
  end

  private

  def should_update_recording?
    title_changed? || todo_list_id_changed?
  end

  # def update_completed_subscribers
  #   if notifiee_ids.present?
  #     subscription = completed_subscription
  #     notifiee_ids.each do |user_id|
  #       subscription.subscribers.create!(user_id: user_id)
  #     end
  #   elsif !notifiee_ids.nil? && notifiee_ids.empty?
  #     subscription = completed_subscription
  #     subscription.subscribers.destroy_all
  #   else
  #     # do nothing if not intentionally modifying notifiees
  #   end
  # end

  # def emit_events
  #   if completed_changed? && completed?
  #     recording.events.build(action: "todo.completed", creator: creator)
  #   elsif completed_changed? && !completed?
  #     recording.events.build(action: "todo.reopened", creator: creator)
  #   end
  # end
end
