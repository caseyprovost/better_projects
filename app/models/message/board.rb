class Message::Board < ApplicationRecord
  self.table_name = "message_boards"

  belongs_to :project
  has_many :messages, dependent: :destroy, foreign_key: :message_board_id

  delegate :bucket, to: :project
end
