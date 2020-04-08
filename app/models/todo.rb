class Todo < ApplicationRecord
  include Recordable, HasRecordingStatus, HasPosition

  # To-dos are due soon if they are due tomorrow
  DUE_SOON_DAYS = 1

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

  scope :due_soon, -> {
    date = DateTime.today.advance(days: DUE_SOON_DAYS)
    where.not(due_on: nil).where(due_on: date.beginning_of_day..date.end_of_day)
  }

  def description_preview
    description.to_plain_text
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

  def completed_subscription
    recording.subscriptions.find_by(action: "todo.completed")
  end

  private

  def should_update_recording?
    title_changed? || todo_list_id_changed?
  end

  def change_assignees
    if assignee_ids.present?
      assignee_ids.each do |user_id|
        assignments.create!(user_id: user.id)
      end
    elsif !assignee_ids.nil? && assignee_ids.empty?
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
    elsif !notifiee_ids.nil? && notifiee_ids.empty?
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
