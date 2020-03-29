class Move
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :project_id, :integer
  attribute :resource
  attribute :user
  attribute :project

  validates :project_id, presence: true

  def save
    raise "Not Yet Implemented"
  end
end
