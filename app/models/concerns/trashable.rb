module Trashable
  extend ActiveSupport::Concern

  included do
    belongs_to :trashed_by, class_name: "User", optional: true
  end

  def trash(garbage_man = nil)
    attrs = {status: "trashed", trashed_by: garbage_man, trashed_at: Time.zone.now}
    trash_attributes = attrs.keep_if { |_, value| value.present? }
    update(trash_attributes)
  end

  def untrash
    update(status: "active", trashed_by: nil)
  end

  def trashed?
    status == "trashed"
  end
end
