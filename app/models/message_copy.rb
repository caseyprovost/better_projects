class MessageCopy
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :project_id, :integer
  attribute :source_message
  attribute :user
  attribute :project

  attr_reader :message

  validates :project_id, presence: true

  def save
    @message = source_message.amoeba_dup
    @message.assign_attributes(
      creator: user,
      message_board: message_board
    )
    @message.save
  end

  private

  def message_board
    return @message_board if @message_board

    if project.message_board.nil?
      MessageBoard.create!(project: project)
    end

     @message_board = project.message_board
  end
end
