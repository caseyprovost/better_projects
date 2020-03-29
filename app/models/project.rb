class Project < ApplicationRecord
  belongs_to :account
  has_many :memberships, class_name: "ProjectMembership"
  has_many :users, through: :memberships

  has_one :message_board
  has_many :messages, through: :message_board

  validates :name, :description, presence: true
  validates :name, uniqueness: {scope: :account_id}

  after_initialize :set_default_status

  private

  def set_default_status
    self.status ||= "active"
  end
end
