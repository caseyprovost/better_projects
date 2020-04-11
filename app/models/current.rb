class Current < ActiveSupport::CurrentAttributes
  attribute :account
  attribute :user
  attribute :request_id
  attribute :user_agent
  attribute :ip_address

  resets { Time.zone = nil }

  def user=(user)
    super
    Time.zone = user.try(:time_zone)
  end
end
