class Event < ApplicationRecord
  belongs_to :recording
  belongs_to :creator, optional: true, class_name: "User", default: -> { User.current }

  def text
    @text = creator.name

    if sub_action == "reopened"
      @text += " re-opened"
    else
      @text += " #{sub_action}"
    end

    @text += " this #{topic}"
    @text
  end

  private

  def topic
    base_topic = action.split(".").first
    base_topic == "todo" ? "to-do" : base_topic
  end

  def sub_action
    action.split(".").last
  end
end
