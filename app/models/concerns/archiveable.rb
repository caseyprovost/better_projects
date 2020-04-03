module Archiveable
  extend ActiveSupport::Concern

  included do
    belongs_to :archived_by, class_name: "User", optional: true
  end

  def archive(archiver = nil)
    attrs = {status: "archived", archived_by: archiver, archived_at: Time.zone.now}
    archive_attributes = attrs.keep_if { |_, value| value.present? }
    update(archive_attributes)
  end

  def unarchive
    update(status: "active", archived_by: nil)
  end

  def archived?
    status == "archived"
  end
end
