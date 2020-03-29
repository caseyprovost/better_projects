class Message < ApplicationRecord
  belongs_to :message_board
  belongs_to :creator, class_name: "User"

  delegate :project, to: :message_board

  has_rich_text :content

  amoeba do
    enable
    include_association :rich_text_content
  end

  def content_preview
    content.to_plain_text
  end
end
