module Recordable
  extend ActiveSupport::Concern

  included do
    has_one :recording, as: :recordable, autosave: true

    default_scope { joins(:recording) }
    scope :active, -> { where.not(recordings: { status: ["archived", "trashed"] }) }

    has_paper_trail
  end
end
