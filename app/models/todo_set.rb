class TodoSet < ApplicationRecord
  belongs_to :bucket
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  has_many :todo_lists
  has_many :todos, through: :todo_lists

  def positionable_children
    todo_lists
  end
end
