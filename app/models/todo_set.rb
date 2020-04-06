class TodoSet < ApplicationRecord
  belongs_to :bucket
  belongs_to :creator, class_name: "User"
  has_many :todo_lists
  has_many :todos, through: :todo_lists

  def positionable_children
    todo_lsits
  end
end
