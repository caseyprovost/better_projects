class TodoSet < ApplicationRecord
  belongs_to :bucket
  belongs_to :creator, class_name: "User"
  has_many :todo_lists, as: :parent
  has_many :todos, through: :todo_lists
end
