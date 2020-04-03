module HasRecordingStatus
  extend ActiveSupport::Concern

  def status
    recording&.status
  end

  def archived?
    recording&.archived?
  end

  def trashed?
    recording&.trashed?
  end
end
