class Todo < ApplicationRecord
  include Recordable, HasRecordingStatus, HasPosition

  attribute :completion_subscribers

  belongs_to :todo_list, counter_cache: true
  belongs_to :creator, class_name: "User", default: -> { User.current }

  has_many :assignments, as: :assignable, autosave: true
  has_many :assignees, through: :assignments

  has_many :subscriptions, through: :recording
  has_many :subscribers, through: :subscriptions

  after_update :emit_events

  has_rich_text :description

  delegate :bucket, to: :parent

  def description_preview
    description.to_plain_text
  end

  def parent
    todo_list
  end

  private

  def emit_events
    if completed_changed? && completed?
      recording.events.create!(action: "todo.completed", creator: Current.user)
    end
  end
end
