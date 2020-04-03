class ProjectMembership < ApplicationRecord
  PERMISSIONS = %w[read write admin]

  belongs_to :project
  belongs_to :user

  before_create :set_status

  private

  def set_status
    self.status ||= "active"
  end
end
