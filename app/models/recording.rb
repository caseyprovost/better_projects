class Recording < ApplicationRecord
  include Archiveable
  include Creator
  include Trashable
  include Recordings::Subscribeable

  belongs_to :bucket
  belongs_to :recordable, polymorphic: true
  belongs_to :parent, class_name: "Recording", optional: true

  has_many :events, autosave: true
  has_many :comments, as: :commentable

  delegate :account, to: :bucket
  delegate :content, :title, to: :recordable

  validates :title, presence: true

  delegate :account, to: :bucket

  amoeba do
    enable
    include_association :recordable
    include_association :subscriptions
    include_association :subscribers
    include_association :events
  end

  def recordable_versions
    recordable.versions
  end

  def recording
    self
  end
end
