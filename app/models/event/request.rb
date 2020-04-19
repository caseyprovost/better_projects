class EventRequest < ApplicationRecord
  set_table_name("event_requets")
  belongs_to :event
  before_create :set_from_current

  private

  def set_from_current
    self.ip_address ||= Current.ip_address
    self.guid ||= Current.request_id
    self.user_agent ||= Current.user_agent
  end
end
