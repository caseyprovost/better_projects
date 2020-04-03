class Bucket < ApplicationRecord
  belongs_to :account
  belongs_to :bucketable, polymorphic: true
  has_many :recordings
  has_many :todo_sets
  has_many :todo_lists, through: :todo_sets
  has_many :todos, through: :todo_lists

  delegate :name, to: :bucketable

  before_create :set_up_the_world

  def record
    bucketable
  end

  private

  def set_up_the_world
    if todo_sets.empty?
      self.todo_sets.build(title: "To-dos")
    end
    # self.vaults.build(name: "Docs & Files")
  end
end
