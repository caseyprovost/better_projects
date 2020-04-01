class Project < ApplicationRecord
  belongs_to :account
  has_many :memberships, class_name: "ProjectMembership", dependent: :destroy
  has_many :users, through: :memberships

  has_one :message_board, dependent: :destroy
  has_many :messages, through: :message_board

  validates :name, :description, presence: true
  validates :name, uniqueness: {scope: :account_id}

  after_initialize :set_default_status
  before_create :set_up_the_world

  private

  def set_default_status
    self.status ||= "active"
  end

  def set_up_the_world
    build_message_board if message_board.nil?
    # self.vaults.build(name: "Docs & Files")
  end
end
