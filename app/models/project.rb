class Project < ApplicationRecord
  include Creator

  belongs_to :account
  has_many :memberships, class_name: "ProjectMembership", dependent: :destroy
  has_many :users, through: :memberships

  has_one :message_board, class_name: "Message::Board", dependent: :destroy
  has_one :bucket, as: :bucketable, dependent: :destroy
  has_many :messages, through: :message_board

  validates :name, :description, presence: true
  validates :name, uniqueness: {scope: :account_id}

  after_initialize :set_default_status
  before_create :set_up_the_world

  has_paper_trail

  private

  def set_default_status
    self.status ||= "active"
  end

  def set_up_the_world
    build_message_board if message_board.nil?
    build_bucket(account: account) if bucket.nil?
    # self.vaults.build(name: "Docs & Files")
  end
end
