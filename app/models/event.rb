class Event < ApplicationRecord
  include Creator, Recordable

  belongs_to :bucket

  validates :action, presence: true

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

  def detail
    @detail ||= Event::Detail.new(details.except(*excluded_details))
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
