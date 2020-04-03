class TodoList < ApplicationRecord
  include Recordable, HasRecordingStatus

  belongs_to :parent, class_name: "TodoSet", counter_cache: true
  belongs_to :creator, class_name: "User"
  has_many :todos, as: :parent

  has_rich_text :description
end
