class Message < ApplicationRecord
  include Recordable

  belongs_to :message_board
  belongs_to :creator, class_name: "User"

  delegate :project, to: :message_board
  delegate :bucket, to: :project

  validates :subject, presence: true
  validate :validate_content_exists

  has_rich_text :content

  after_commit :remove_up_bad_version, on: :create

  amoeba do
    include_association :rich_text_content
    exclude_association :versions
    exclude_association :recording
    exclude_association :message_board
    exclude_association :creator
  end

  def status
    recording&.status
  end

  def content_preview
    content.to_plain_text
  end

  def title
    subject
  end

  def parent
    message_board
  end

  def should_update_recording?
    subject_changed? || message_board_id_changed?
  end

  private

  # IMPORTANT: This is a nasty little patch
  #
  # Context: There is some strange interaction between ActionText and PaperTrail where
  # when an object is created with rich text 2 versions are created, a "created" one that is correct
  # and an "update" on that HAS NO CHANGES.
  def remove_up_bad_version
    last_version = versions.last

    if versions.count == 2 && last_version.changeset.empty?
      versions.last.destroy
    end
  end

  def validate_content_exists
    return if content_preview.length > 0
    errors.add(:content, "can't be blank")
  end
end
