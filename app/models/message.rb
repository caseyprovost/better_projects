class Message < ApplicationRecord
  include Recordable, HasRecordingStatus, Creator
  include Commentable # depends on Recordable

  belongs_to :message_board, class_name: "Message::Board", foreign_key: :message_board_id

  delegate :project, to: :message_board
  delegate :bucket, to: :project
  delegate :account, to: :bucket

  validates :subject, presence: true
  validate :validate_content_exists

  has_rich_text :content

  amoeba do
    include_association :rich_text_content
    exclude_association :versions
    exclude_association :recording
    exclude_association :message_board
    exclude_association :creator
  end

  def subscribeable?
    true
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

  private

  def validate_content_exists
    return if content_preview.length > 0
    errors.add(:content, "can't be blank")
  end
end
