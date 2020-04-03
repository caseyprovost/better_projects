class Todo < ApplicationRecord
  include Recordable, HasRecordingStatus

  belongs_to :parent, class_name: "TodoList"
  belongs_to :creator, class_name: "User"
  has_many :assignments, as: :assignable
  has_many :assignees, through: :assignments

  has_rich_text :description

  def description_preview
    description.to_plain_text
  end
end
