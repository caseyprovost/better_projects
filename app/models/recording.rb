class Recording < ApplicationRecord
  include Archiveable
  include Trashable

  belongs_to :bucket
  belongs_to :recordable, polymorphic: true
  belongs_to :parent, polymorphic: true, optional: true
  belongs_to :creator, class_name: "User", optional: true

  has_many :subscriptions, dependent: :delete_all
  has_many :subscribers, through: :subscriptions
  has_many :events

  delegate :account, to: :bucket
  delegate :content, :title, to: :recordable

  after_create :generate_subscriptions

  validates :title, presence: true

  amoeba do
    enable
    include_association :recordable
  end

  def recordable_versions
    recordable.versions
  end

  private

  def generate_subscriptions
    recording.subscriptions.create!(action: "comment.created")

    if recordable.is_a?(Todo)
      recording.subscriptions.create!(action: "todo.completed")
    end
  end
end
