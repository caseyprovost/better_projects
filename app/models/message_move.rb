class MessageMove < Move
  def save
    resource.update(message_board: message_board)
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
