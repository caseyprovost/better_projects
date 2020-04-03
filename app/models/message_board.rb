class MessageBoard < ApplicationRecord
  belongs_to :project
  has_many :messages, dependent: :destroy

  delegate :bucket, to: :project
end
