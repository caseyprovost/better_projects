class Recording < ApplicationRecord
  include Archiveable
  include Trashable

  belongs_to :bucket
  belongs_to :recordable, polymorphic: true
  belongs_to :parent, polymorphic: true, optional: true
  belongs_to :creator, class_name: "User", optional: true

  delegate :account, to: :bucket
  delegate :content, :title, to: :recordable

  validates :title, presence: true

  amoeba do
    enable
    include_association :recordable
  end

  def recordable_versions
    recordable.versions
  end
end
