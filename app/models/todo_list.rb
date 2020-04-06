class TodoList < ApplicationRecord
  include Recordable, HasRecordingStatus, HasPosition

  belongs_to :todo_set, counter_cache: true
  belongs_to :creator, class_name: "User"
  has_many :todos

  has_rich_text :description

  delegate :bucket, to: :parent

  def parent
    todo_set
  end

  def positionable_children
    todos
  end
end
