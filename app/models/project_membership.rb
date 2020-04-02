class ProjectMembership < ApplicationRecord
  PERMISSIONS = %w[read write admin]

  belongs_to :project
  belongs_to :user

  validates :permission, presence: true
  validates :permission, inclusion: {in: PERMISSIONS}

  before_create :set_status

  def admin?
    slug == "admin"
  end

  def reader?
    slug == "read"
  end

  def writer?
    slug == "write"
  end

  private

  def set_status
    self.status ||= "active"
  end
end
