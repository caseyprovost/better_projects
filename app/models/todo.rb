class Todo < ApplicationRecord
  include Recordable, HasRecordingStatus, HasPosition

  attribute :notifiee_ids
  attribute :assignee_ids

  belongs_to :todo_list, counter_cache: true
  belongs_to :creator, class_name: "User", default: -> { User.current }

  has_many :assignments, as: :assignable, autosave: true
  has_many :assignees, through: :assignments

  has_many :subscriptions, through: :recording
  has_many :subscribers, through: :subscriptions

  after_update :emit_events
  after_save :update_completed_subscribers
  after_save :change_assignees

  validates :title, presence: true

  has_rich_text :description

  delegate :bucket, to: :parent

  def description_preview
    description.to_plain_text
  end

  def parent
    todo_list
  end

  def completed_subscription
    recording.subscriptions.find_by(action: "todo.completed")
  end

  private

  def change_assignees
    if assignee_ids.present?
      assignee_ids.each do |user_id|
        assignments.create!(user_id: user.id)
      end
    elsif assignee_ids.empty?
      assignments.destroy_all
    else
      # do nothing if not intentionally modifying assignees
    end
  end

  def update_completed_subscribers
    if notifiee_ids.present?
      subscription = completed_subscription
      notifiee_ids.each do |user_id|
        subscription.subscribers.create!(user_id: user_id)
      end
    elsif notifiee_ids.empty?
      subscription = completed_subscription
      subscription.subscribers.destroy_all
    else
      # do nothing if not intentionally modifying notifiees
    end
  end

  def emit_events
    if completed_changed? && completed?
      recording.events.create!(action: "todo.completed", creator: Current.user)
    end
  end
end
