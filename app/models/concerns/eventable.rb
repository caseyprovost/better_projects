module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, through: :recording
  end
end
